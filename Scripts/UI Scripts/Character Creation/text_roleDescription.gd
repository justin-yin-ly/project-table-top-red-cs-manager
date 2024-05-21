extends Node

@export var abilityDescription: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_item_selected(index):
	match index:
		0:
			self.text = "Corporate power brokers and business raiders fighing to \n restore the rule of the Megacorps."
			abilityDescription.text = "Just like a real corporate executive, the Exec builds a team 
			whose members help them accomplish their goals, whether 
			legal or not, morale permitting. The Exec Role Ability 
			is Teamwork. A variety of underlings will be at your
			disposal to help accomplish your goals; just make sure
			they don't feel like filing a complaint to HR."
		1:
			self.text = "Dealmakers, organizers, and information brokers in the \n post-War Midnight Markets of The Street."
			abilityDescription.text = "The Fixer's Role Ability is Operator. Fixers know how to get 
			things on the black market and are adept at navigating the 
			complex social customs of The Street, where hundreds of 
			cultures and economic levels collide. Fixers maintain vast 
			webs of contacts and clients."
		2:
			self.text = "Maximum law enforcers patrolling the mean streets and \n barbarian warrior highways beyond."
			abilityDescription.text = "The Lawman's Role Ability is Backup. Lawmen can call upon the 
			help of a group of fellow law enforcers, based on the 
			Lawman's Backup Rank and the conditions under which the 
			call is made. The Backup will be armed and armored based on 
			a specified table, and will be played by the GM."
		3:
			self.text = "Reporters, media stars, and social influencers risking \n it all for the truth—or glory."
			abilityDescription.text = "The Media Role Ability is Credibility. The Media not only can 
			convince an audience of what they publish, but also has a 
			larger audience the more credible they are. They also have 
			greater levels of access to sources and information. Medias 
			are also in the know and pick up on rumors passively."
		4:
			self.text = "Unsanctioned street doctors and cyberware medics, \n patching up meat and metal alike."
			abilityDescription.text = "Medtechs keep people alive who should be dead with their 
			knowledge and training. In the Time of the Red, they are as 
			much mechanics as they are doctors, caring for people who 
			are oftentimes more machine than human. The Medtech Role 
			Ability is Medicine."
		5:
			self.text = "Cybernetic master hackers of the post-NET world and \n brain-burning secret stealers."
			abilityDescription.text = "A Netrunner's Interface Role Ability allows them to Netrun, 
			determines how many NET Actions they can take on their Turn, 
			and gives them access to a suite of Interface Abilities.
			Peer into the digital world and behold the secrets that 
			lie within cyberspace. Beware though - you will be vulnerable 
			to threats both meat and NET alike."
		6:
			self.text = "Transport experts, ultimate road warriors, pirates, and \n smugglers who keep the world connected."
			abilityDescription.text = "The difference between most people and Nomads is that 
			Nomads have better cars. The Nomad Role Ability is Moto. 
			Being part of a Nomad Family means spending your life in 
			the driver's seat and under the hood, improving your driving 
			abilities and vehicle knowledge enough to get by on familiarity 
			alone or with training to pull off impressive feats with ease."
		7:
			self.text = "Rock-and-roll rebels who use performance, art, and \n rhetoric to fight authority."
			abilityDescription.text = "The Rockerboy has the Role ability Charismatic Impact. They can
			influence others by sheer presence of person-ality. They need 
			not be a musical performer; they can influence others through 
			poetry, art, dance, or simply their physical presence. They could 
			be a rocker—or a cult leader."
		8:
			self.text = "Assassins, bodyguards, killers, and soldiers-for-hire \n in a lawless new world."
			abilityDescription.text = "When combat begins (before Initiative is rolled), anytime 
			outside of combat, or in combat with an Action, a Solo may 
			divide the total number of points they have in their Combat 
			Awareness Role Ability among several abilities. If a Solo 
			chooses to not change their point assignments, their previous 
			ones persist. Activating some of these abilities will cost the 
			Solo more points than others."
		9:
			self.text = "Renegade mechanics and supertech inventors; the people \n who make the Dark Future run."
			abilityDescription.text = "A Tech can fix, improve, modify, make, and invent new items 
			using Maker, their Role Ability. Techs also flex a general
			knowledge of all things tech-related, making them viable for 
			any situation where something breaks down. The only limit to 
			what you can create is what you can get your hands on (and
			whatever your GM will allow)."
	pass # Replace with function body.
