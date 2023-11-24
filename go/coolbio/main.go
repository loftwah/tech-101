package main

import (
	"fmt"
	"strings"
)

type Bio struct {
	Name                string
	Alias               string
	Profession          string
	Skills              []string
	Projects            []string
	MilitaryAwards      []string
	TechnicalLeadership string
	Innovation          string
	Mentorship          string
	ExternalRecognition string
	Impact              string
	FavoriteTools       []string
}

func (b *Bio) Display() {
	fmt.Printf("👋 Hey, check this out:\n")
	fmt.Printf("------------------------\n")
	fmt.Printf("👤 Name: %s (Alias: %s)\n", b.Name, b.Alias)
	fmt.Printf("💼 Profession: %s\n", b.Profession)
	fmt.Printf("🛠️ Skills: %s\n", strings.Join(b.Skills, ", "))
	fmt.Printf("🔗 Projects: %s\n", strings.Join(b.Projects, ", "))
	fmt.Printf("🎵 Music Production: %s\n", b.Alias)
	fmt.Printf("🎖️ Military Awards: %s\n", strings.Join(b.MilitaryAwards, ", "))
	fmt.Printf("🧠 Technical Leadership: %s\n", b.TechnicalLeadership)
	fmt.Printf("💡 Innovation: %s\n", b.Innovation)
	fmt.Printf("👥 Mentorship: %s\n", b.Mentorship)
	fmt.Printf("🌟 External Recognition: %s\n", b.ExternalRecognition)
	fmt.Printf("💥 Impact: %s\n", b.Impact)
	fmt.Printf("🛠️ Favorite Tools: %s\n", strings.Join(b.FavoriteTools, ", "))
	fmt.Printf("------------------------\n")
}

func main() {
	bio := Bio{
		Name:                "Dean Lofts",
		Alias:               "Loftwah",
		Profession:          "Senior DevOps Engineer & AI Enthusiast",
		Skills:              []string{"Go", "AI", "Docker", "Linux", "Cloud Infrastructure"},
		Projects:            []string{"1on1-automation", "echo-playground", "OpenAI Demonstrations"},
		MilitaryAwards:      []string{"Iraq Medal", "Australian Active Service Medal", "Australian Defence Medal"},
		TechnicalLeadership: "Pioneered the integration of Tailscale for enhanced security across the network",
		Innovation:          "Developed and managed custom deployment systems using Ruby and AWS SDK",
		Mentorship:          "Guided teams in DevOps best practices, influencing company-wide adoption",
		ExternalRecognition: "Produced a music track with over 300k streams, engaged in tech community growth",
		Impact:              "Implemented cost optimizations saving a third of salary in monthly AWS costs",
		FavoriteTools:       []string{"Go", "Terraform", "AWS", "VSCode"},
	}

	bio.Display()
}
