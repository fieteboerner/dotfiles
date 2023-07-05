package main

import (
	"context"
	"errors"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"

	"gopkg.in/vansante/go-ffprobe.v2"
)

func main() {

	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "please pass a filepath")
		os.Exit(0)
	}

	path := os.Args[1]

	if _, err := os.Stat(path); err != nil {
		fmt.Println(fmt.Sprintf("File %s does not exists", path))
		os.Exit(1)
	}

	as, err := NewAudioSwitcher(path)
	if err != nil {
		log.Panic(fmt.Sprintf("unable to instantiate audio switcher: %s", err))
	}
	err = as.Swap()

	if err != nil {
		log.Panic(err)

		return
	}
	fmt.Println("Remap succeed")
}

type AudioSwitcher struct {
	filePath string
	data     *ffprobe.ProbeData
	args     []string
}

func NewAudioSwitcher(path string) (*AudioSwitcher, error) {
	as := &AudioSwitcher{
		filePath: path,
		data:     nil,
		args:     []string{},
	}
	data, err := as.getFfProbeData()
	if err != nil {
		return nil, err
	}
	as.data = data

	if as.isEnglishTheDefaultLanguage() {
		return nil, errors.New("eng audio already on first position and default disposition")
	}

	return as, err
}

func (as *AudioSwitcher) getFfProbeData() (*ffprobe.ProbeData, error) {
	ffprobe.SetFFProbeBinPath("/usr/bin/ffprobe")
	ctx, cancelFn := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancelFn()

	return ffprobe.ProbeURL(ctx, as.filePath)
}

func (as *AudioSwitcher) isEnglishTheDefaultLanguage() bool {
	for _, stream := range as.data.Streams {
		if stream.CodecType == "audio" && stream.Index == 1 {
			language, err := stream.TagList.GetString("language")
			if err != nil {
				return false
			}

			return language == "eng" && stream.Disposition.Default == 1
		}
	}

	return false
}

func (as *AudioSwitcher) Swap() error {
	filename := filepath.Base(as.filePath)
	extension := filepath.Ext(filename)
	basename := filename[:len(filename)-len(extension)]
	dir := filepath.Dir(as.filePath)

	temporaryFileName := basename + "-r" + extension
	temporaryPath := filepath.Join(dir, temporaryFileName)

	as.args = append(as.args, []string{
		"-i", as.filePath,
		"-map", "0:v:0",
		"-map", "0:s",
	}...)

	as.addAudioArgs()

	as.args = append(as.args, []string{
		"-c", "copy",
		temporaryPath,
	}...)

	err := execCommand("ffmpeg", as.args...)

	if err != nil {
		return err
	}

	os.Rename(as.filePath, filepath.Join(dir, basename+"-old"+extension))
	os.Rename(temporaryPath, as.filePath)

	return nil
}

func (as *AudioSwitcher) addAudioArgs() {
	audioStreams := []*ffprobe.Stream{}

	for _, stream := range as.data.Streams {
		if stream.CodecType != "audio" {
			continue
		}
		language, _ := stream.TagList.GetString("language")
		if language == "eng" {
			// prepend eng stream to top
			audioStreams = append([]*ffprobe.Stream{stream}, audioStreams...)
		} else {
			audioStreams = append(audioStreams, stream)
		}
	}

	audioMapArgs := []string{}
	dispositionArgs := []string{}

	for i, s := range audioStreams {
		audioMapArgs = append(audioMapArgs, "-map")
		audioMapArgs = append(audioMapArgs, fmt.Sprintf("0:a:%d", s.Index-1))

		language, _ := s.TagList.GetString("language")
		dispositionArgs = append(dispositionArgs, fmt.Sprintf("-disposition:a:%d", i))
		dispositionValue := "-default"
		if language == "eng" {
			dispositionValue = "default"
		}
		dispositionArgs = append(dispositionArgs, dispositionValue)
	}

	as.args = append(as.args, audioMapArgs...)
	as.args = append(as.args, dispositionArgs...)
}

func execCommand(command string, args ...string) error {
    fmt.Printf("%s %s\n", command, strings.Join(args, " "))
    return nil
	cmd := exec.Command(command, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin

	err := cmd.Start()
	if err != nil {
		return err
	}
	err = cmd.Wait()
	if err != nil {
		return err
	}

	return nil
}
