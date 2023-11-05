package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
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

	data, err := getFfProbeData(path)
	if err != nil {
		fmt.Println(fmt.Sprintf("unable to extract metadata: %s", err))
		os.Exit(1)
	}

	if isEnglishTheDefaultLanguage(data) {
		fmt.Println("eng audio already on first position and default disposition")
		os.Exit(1)
	}
	err = simpleSwapAudioStreams(path, data)
	if err != nil {
		log.Panic(err)
		os.Exit(1)

		return
	}
	fmt.Println("Remap succeed")

}

func getFfProbeData(path string) (*ffprobe.ProbeData, error) {
	ffprobe.SetFFProbeBinPath("/usr/bin/ffprobe")
	ctx, cancelFn := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancelFn()

	return ffprobe.ProbeURL(ctx, path)
}

func isEnglishTheDefaultLanguage(data *ffprobe.ProbeData) bool {
	for _, stream := range data.Streams {
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

func hasSubtitles(data *ffprobe.ProbeData) bool {
	for _, stream := range data.Streams {
		if stream.CodecType == "subtitle" {
			return true
		}
	}

	return false
}
func simpleSwapAudioStreams(path string, data *ffprobe.ProbeData) error {
	filename := filepath.Base(path)
	extension := filepath.Ext(filename)
	basename := filename[:len(filename)-len(extension)]
	dir := filepath.Dir(path)

	temporaryFileName := basename + "-r" + extension
	temporaryPath := filepath.Join(dir, temporaryFileName)

	args := []string{
		"-i", path,
		"-map", "0:v:0",
		// disabled static switching in favor of dynamic switching
		// "-map", "0:a:1",
		// "-map", "0:a:0",
		// "-disposition:a:0", "default",
		// "-disposition:a:1", "-default",
		// "-disposition:a:1", "-forced", // sometimes there is a forced-flag on the german stream. - so remove it
		// "-c", "copy",
	}
	if hasSubtitles(data) {
		args = append(args, "-map", "0:s")
	}

	audioArgs := getAudioArgs(data)
	args = append(args, audioArgs...)
	args = append(args, "-c", "copy")

	args = append(args, temporaryPath) //output file

	// for _, arg := range args {
	// 	fmt.Println(arg)
	// }
	// panic("stop")

	err := execCommand("ffmpeg", args...)

	if err != nil {
		return err
	}

	os.Rename(path, filepath.Join(dir, basename+"-old"+extension))
	os.Rename(temporaryPath, path)

	return nil
}

func getAudioArgs(data *ffprobe.ProbeData) []string {
	audioStreams := []*ffprobe.Stream{}

	for _, stream := range data.Streams {
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
	defaultUsed := false

	for i, s := range audioStreams {
		audioMapArgs = append(audioMapArgs, "-map")
		audioMapArgs = append(audioMapArgs, fmt.Sprintf("0:a:%d", s.Index-1))

		language, _ := s.TagList.GetString("language")
		dispositionArgs = append(dispositionArgs, fmt.Sprintf("-disposition:a:%d", i))
		dispositionValue := "-default"
		if language == "eng" && !defaultUsed {
			dispositionValue = "default"
			defaultUsed = true
		}
		dispositionArgs = append(dispositionArgs, dispositionValue)
	}

	args := []string{}
	args = append(args, audioMapArgs...)
	args = append(args, dispositionArgs...)

	return args
}

// func getAudioMaps(data *ffprobe.ProbeData) []string {
// 	const maps []string{}
// 	const defaultIndex = 0
// 	const englishIndex = 1

// 	return maps
// }

func execCommand(command string, args ...string) error {
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
