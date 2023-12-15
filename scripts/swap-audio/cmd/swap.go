package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"swap-audio/util"

	"github.com/spf13/cobra"
)

var swapCommand = &cobra.Command{
	Use:   "swap",
	Short: "swap the actual audio streams",
	Args:  cobra.MinimumNArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		inputPath := args[0]
		outputPath := getAltFileName(inputPath, "temp")
		newDefaultLang, _ := cmd.Flags().GetString("language")
		dryRun, _ := cmd.Flags().GetBool("dry-run")
		swapper := util.NewSwapper(inputPath, outputPath, newDefaultLang, dryRun)

		if err := swapper.Swap(); err != nil {
			fmt.Printf("An error occurred %q", err)
			os.Exit(1)
		}
		if dryRun {
			fmt.Printf("Rename files")

		} else {
			os.Rename(inputPath, getAltFileName(inputPath, "old"))
			os.Rename(outputPath, inputPath)
		}

	},
}

func getAltFileName(path string, suffix string) string {
	filename := filepath.Base(path)
	extension := filepath.Ext(filename)
	basename := filename[:len(filename)-len(extension)]
	dir := filepath.Dir(path)

	return filepath.Join(dir, fmt.Sprintf("%s.%s%s", basename, suffix, extension))
}

func init() {
	swapCommand.PersistentFlags().Bool("dry-run", false, "just prints the ffmpeg command, but doesn't execute it")
	swapCommand.PersistentFlags().String("language", "eng", "the language what should be the first audio track")
	rootCmd.AddCommand(swapCommand)
}
