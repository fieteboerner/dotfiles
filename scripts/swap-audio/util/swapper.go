package util

import (
	"context"
	"fmt"
	"os"
	"time"

	"gopkg.in/vansante/go-ffprobe.v2"
)

type Swapper struct {
	data           *ffprobe.ProbeData
	dryRun         bool
	inputPath      string
	outputPath     string
	newDefaultLang string
}

func NewSwapper(inputPath string, outputPath string, newDefaultLang string, dryRun bool) *Swapper {

	return &Swapper{
		inputPath:      inputPath,
		dryRun:         dryRun,
		outputPath:     outputPath,
		newDefaultLang: newDefaultLang,
	}
}

func (s *Swapper) initFfProbeData() error {
	ctx, cancelFn := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancelFn()

	data, err := ffprobe.ProbeURL(ctx, s.inputPath)
	if err != nil {
		return err
	}
	s.data = data

	return nil
}

func (s Swapper) isLanguageTheDefaultLanguage(language string) bool {
	for _, stream := range s.data.Streams {
		if stream.CodecType == "audio" && stream.Index == 1 {
			lang, err := stream.TagList.GetString("language")
			if err != nil {
				return false
			}

			return lang == language && stream.Disposition.Default == 1
		}
	}

	return false
}

func (s Swapper) hasSubtitles() bool {
	for _, stream := range s.data.Streams {
		if stream.CodecType == "subtitle" {
			return true
		}
	}

	return false
}

func (s Swapper) generateArgs() []string {
	args := []string{
		"-i", s.inputPath,
		"-map", "0:v:0",
	}

	if s.hasSubtitles() {
		args = append(args, "-map", "0:s")
	}

	audioArgs := s.getAudioArgs()
	args = append(args, audioArgs...)
	args = append(args, "-c", "copy")

	args = append(args, s.outputPath) //output file

	return args
}

func (s Swapper) getAudioArgs() []string {
	audioStreams := []*ffprobe.Stream{}
	defaultAudioSetFirst := false

	for _, stream := range s.data.Streams {
		if stream.CodecType != "audio" {
			continue
		}
		language, _ := stream.TagList.GetString("language")
		if language == s.newDefaultLang && !defaultAudioSetFirst {
			audioStreams = append([]*ffprobe.Stream{stream}, audioStreams...)
			defaultAudioSetFirst = true
		} else {
			audioStreams = append(audioStreams, stream)
		}
	}

	audioMapArgs := []string{}
	dispositionArgs := []string{}
	defaultUsed := false

	for i, stream := range audioStreams {
		audioMapArgs = append(audioMapArgs, "-map")
		audioMapArgs = append(audioMapArgs, fmt.Sprintf("0:a:%d", stream.Index-1))

		language, _ := stream.TagList.GetString("language")
		dispositionArgs = append(dispositionArgs, fmt.Sprintf("-disposition:a:%d", i))
		dispositionValue := "-default"
		if language == s.newDefaultLang && !defaultUsed {
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

func (s Swapper) Swap() error {
	if _, err := os.Stat(s.inputPath); err != nil {
		return fmt.Errorf("File %s does not exists", s.inputPath)
	}
	if err := s.initFfProbeData(); err != nil {
		return err
	}

	if s.isLanguageTheDefaultLanguage(s.newDefaultLang) {
		return fmt.Errorf("Lang %q already on first position", s.newDefaultLang)
	}

	args := s.generateArgs()
	if s.dryRun {
		fmt.Printf("%v\n", args)
		return nil
	}
	return execCommand("ffmpeg", args...)
}
