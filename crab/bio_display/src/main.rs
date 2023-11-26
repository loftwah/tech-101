struct Bio {
    name: String,
    alias: String,
    profession: String,
    skills: Vec<String>,
    projects: Vec<String>,
    military_awards: Vec<String>,
    technical_leadership: String,
    innovation: String,
    mentorship: String,
    external_recognition: String,
    impact: String,
    favorite_tools: Vec<String>,
}

impl Bio {
    fn display(&self) {
        println!("👋 Hey, check this out:");
        println!("------------------------");
        println!("👤 Name: {} (Alias: {})", self.name, self.alias);
        println!("💼 Profession: {}", self.profession);
        println!("🛠️ Skills: {}", self.skills.join(", "));
        println!("🔗 Projects: {}", self.projects.join(", "));
        println!("🎵 Music Production: {}", self.alias);
        println!("🎖️ Military Awards: {}", self.military_awards.join(", "));
        println!("🧠 Technical Leadership: {}", self.technical_leadership);
        println!("💡 Innovation: {}", self.innovation);
        println!("👥 Mentorship: {}", self.mentorship);
        println!("🌟 External Recognition: {}", self.external_recognition);
        println!("💥 Impact: {}", self.impact);
        println!("🛠️ Favorite Tools: {}", self.favorite_tools.join(", "));
        println!("------------------------");
    }
}

fn main() {
    let bio = Bio {
        name: "Dean Lofts".to_string(),
        alias: "Loftwah".to_string(),
        profession: "Senior DevOps Engineer & AI Enthusiast".to_string(),
        skills: vec!["Go".to_string(), "AI".to_string(), "Docker".to_string(), "Linux".to_string(), "Cloud Infrastructure".to_string()],
        projects: vec!["1on1-automation".to_string(), "echo-playground".to_string(), "OpenAI Demonstrations".to_string()],
        military_awards: vec!["Iraq Medal".to_string(), "Australian Active Service Medal".to_string(), "Australian Defence Medal".to_string()],
        technical_leadership: "Pioneered the integration of Tailscale for enhanced security across the network".to_string(),
        innovation: "Developed and managed custom deployment systems using Ruby and AWS SDK".to_string(),
        mentorship: "Guided teams in DevOps best practices, influencing company-wide adoption".to_string(),
        external_recognition: "Produced a music track with over 300k streams, engaged in tech community growth".to_string(),
        impact: "Implemented cost optimizations saving a third of salary in monthly AWS costs".to_string(),
        favorite_tools: vec!["Go".to_string(), "Terraform".to_string(), "AWS".to_string(), "VSCode".to_string()],
    };

    bio.display();
}
