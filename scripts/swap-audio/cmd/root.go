package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "swap-audio",
	Short: "this tool swaps audio tracks, so the audio track of the desired langugage is the first one",
	Run: func(cmd *cobra.Command, args []string) {
		// Do Stuff Here
		verbose, _ := cmd.Flags().GetBool("verbose")

		fmt.Println("verbose:", verbose)
	},
}

func init() {
	rootCmd.PersistentFlags().Bool("verbose", false, "verbose output")
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
