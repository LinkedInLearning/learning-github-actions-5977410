package main

import (
	"fmt"
	"time"
)

type AWSRegion struct {
	Name     string
	Timezone string
}

func main() {
	// AWS regions in order from West to East
	awsRegions := []AWSRegion{
		// Americas
		{"us-west-1", "America/Los_Angeles"},
		{"us-west-2", "America/Los_Angeles"},
		{"ca-central-1", "America/Toronto"},
		{"us-east-1", "America/New_York"},
		{"us-east-2", "America/New_York"},
		{"sa-east-1", "America/Sao_Paulo"},

		// Europe
		{"eu-west-1", "Europe/Dublin"},
		{"eu-west-2", "Europe/London"},
		{"eu-west-3", "Europe/Paris"},
		{"eu-central-1", "Europe/Berlin"},
		{"eu-north-1", "Europe/Stockholm"},

		// Asia-Pacific
		{"ap-south-1", "Asia/Kolkata"},
		{"ap-southeast-1", "Asia/Singapore"},
		{"ap-northeast-2", "Asia/Seoul"},
		{"ap-northeast-1", "Asia/Tokyo"},
		{"ap-southeast-2", "Australia/Sydney"},
	}

	// Get current UTC time
	now := time.Now()

	fmt.Println("=========================================")
	fmt.Println("Current UTC Time:", now.Format("2006-01-02 15:04:05 MST"))
	fmt.Println("=========================================")
	fmt.Println()
	fmt.Println("=============================")
	fmt.Println("AWS Data Center Current Times")
	fmt.Println("=============================")

	// Display times in the order specified
	for _, region := range awsRegions {
		loc, err := time.LoadLocation(region.Timezone)
		if err != nil {
			fmt.Printf("Error loading timezone for %s: %v\n", region.Name, err)
			continue
		}

		regionalTime := now.In(loc)
		fmt.Printf("%-15s | %s | %s\n",
			region.Name,
			regionalTime.Format("2006-01-02 15:04:05 MST"),
			region.Timezone)
	}
}
