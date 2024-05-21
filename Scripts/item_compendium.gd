extends Node

"""
The basic structure I'm using for items in the item dictionary is as such:
	"Item Name": {
		"tags" : [<tags go here, such as "Equipment","Weapon","Consumable>],
		"description" : "This is a string meant to be a description of the item to be displayed in labels so the player can get info/flavor text about the item",
		"cost" : This is an int that lists how much this item would cost to buy. We can also use it to determine how much it would sell back for (I believe it's 10%?),
		"Use" : This is a string to be used for a function call when the player decides to use this item. This is going to be a bit trickier - I believe you can call functions using a String, and that's what this is intended to be. I'll need to look into passing variables with it too, though,
		"STATReq" : This key should be optional. Only include it for items that actually have a STAT requirement.
	}

For weapons, we also need these additional keys:
		"damage" : int that determines how many d6 to roll on hit,
		"Skill" : string that determines which skill this weapon attacks with,
		"ROF" : int that determines how many times this weapon can be fired in a single attack,
		"Hands" : int that determines how many hands are needed to hold this weapon,
		"Concealable" : bool that indicates if this weapon can be concealed,
		"WeaponType" : string that lists out what weapon type this weapon is

For firearms, they also need these keys on top of that:
		"MagSize" : int that determines how much ammo can be expended before needing to reload,
		"AmmoType" : string that determines what kind of ammo the gun is currently loaded with,
		"Attachments" : Ranged Weapons can equip attachments. This is a dictionary meant to keep track of what's equipped and how many Attachment Slots are left.

For armor, the only extra keys we should need are the following:
		"StoppingPower" : int that determines the base stopping power of this armor,
		"StoppingPower_Cur" : int that determines the current stopping power of this armor. This value gets changed as the armor gets damaged,
		"ArmorPenalty" : int that determines the 'grade' of Armor Penalty applied to the wearer. Grade 1 is -2 to REF, DEX, and MOVE, while Grade 2 is -4.
"""

"""
Base Dictionaries to be copied and pasted

	"Item Name" : {
		"tags" : [],
		"description" : "",
		"cost" : 0,
		"Use" : "",
	}
	
	"Armor Name" : {
		"tags" : [],
		"description" : "",
		"cost" : 0,
		"Use" : "",
		"StoppingPower" : 0,
		"StoppingPower_Cur" : 0
	}
	
	"Weapon Name" : {
		"tags" : [],
		"description" : "",
		"cost" : 0,
		"Use" : "",
		"damage" : 0,
		"Skill" : "",
		"ROF" : 0,
		"Hands" : 1,
		"Concealable" : true,
		"WeaponType" : "",
		"Quality" : "Standard"
	}

	"Firearm Name" : {
		"tags" : [],
		"description" : "",
		"cost" : 0,
		"Use" : "",
		"damage" : 0,
		"Skill" : "",
		"ROF" : 0,
		"Hands" : 1,
		"Concealable" : true,
		"WeaponType" : "",
		"Quality" : "Standard",
		"MagSize" : 0,
		"MagCur" : 0,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	}
	
	"Attachment Name" : {
		"tags" : ["attachment"],
		"inclusion" : [],
		"exclusion" : [],
		"description" : "",
		"cost": 0,
		"slotsCost": 0,
		"Use" : ""
	}
"""

var item_dictionary = {
	"Leathers (Body)" : {
		"tags" : ["armor","equippable","everyday","body"],
		"description" : "Thin leather with reinforced pads at shoulders, hips, and gut. Favored by Nomads and other 'punks who ride bikes. This also includes all those road-warrior wannabes wearing open-butt chaps and random sports equipment",
		"cost" : 20,
		"Use" : "",
		"StoppingPower" : 4,
		"StoppingPower_Cur" : 4
	},
	"Kevlar (Body)" : {
		"tags" : ["armor","equippable","costly","body"],
		"description" : "The favored protection for the past 90 years. To quote DuPont: Kevlar® is a heat-resistant, synthetic, lightweight fiber that delivers high tensile strength that brings improved protection and performance across a range of industries and applications. Like when people are trying to stab or shoot you. Can be made into clothes, vests, jackets, business suits, and even bikinis.",
		"cost" : 50,
		"Use" : "",
		"StoppingPower" : 7,
		"StoppingPower_Cur" : 7
	},
	"Light Armorjack (Body)" : {
		"tags" : ["armor","equippable","premium","body"],
		"description" : "A combination of Kevlar® and plastic meshes inserted into the weave of the fabric. Armorjack provides superior protection, especially against high-velocity bullets.",
		"cost" : 100,
		"Use" : "",
		"StoppingPower" : 11,
		"StoppingPower_Cur" : 11
	},
	"Leathers (Head)" : {
		"tags" : ["armor","equippable","everyday","head"],
		"description" : "Thin leather with reinforced pads at shoulders, hips, and gut. Favored by Nomads and other 'punks who ride bikes. This also includes all those road-warrior wannabes wearing open-butt chaps and random sports equipment",
		"cost" : 20,
		"Use" : "",
		"StoppingPower" : 4,
		"StoppingPower_Cur" : 4
	},
	"Kevlar (Head)" : {
		"tags" : ["armor","equippable","costly","head"],
		"description" : "The favored protection for the past 90 years. To quote DuPont: Kevlar® is a heat-resistant, synthetic, lightweight fiber that delivers high tensile strength that brings improved protection and performance across a range of industries and applications. Like when people are trying to stab or shoot you. Can be made into clothes, vests, jackets, business suits, and even bikinis.",
		"cost" : 50,
		"Use" : "",
		"StoppingPower" : 7,
		"StoppingPower_Cur" : 7
	},
	"Light Armorjack (Head)" : {
		"tags" : ["armor","equippable","premium","head"],
		"description" : "A combination of Kevlar® and plastic meshes inserted into the weave of the fabric. Armorjack provides superior protection, especially against high-velocity bullets.",
		"cost" : 100,
		"Use" : "",
		"StoppingPower" : 11,
		"StoppingPower_Cur" : 11
	},
	"Bodyweight Suit" : {
		"tags" : ["armor","equippable","v.expensive"],
		"description" : "Skinsuit with impact absorbing, sintered armorgel layered in key body areas. Surprisingly, they are also breathable and quite comfortable. Besides giving you a measure of protection, a Bodyweight Suit also has a place to store your Cyberdeck and supports your Interface Plugs so they stay out of the way while you're busy brain-burning that fool who just dared to pop a Hellhound on you. Many Netrunners wear clothing over their Bodyweight Suits, but plenty don't. It's a matter of personal style. Unlike other armor, a Bodyweight Suit isn't bought in two pieces, and must always be worn on both your body and head location. Each location has its own SP11. When repaired, both pieces are repaired at the same time. You can't wear more than one Bodyweight Suit. Wearing a Bodyweight Suit adds one Hardware only Option Slot to a Cyberdeck connected to it. Hardware installed in the Bodyweight Suit cannot be accessed if the armor isn't worn and can only take up 1 Option Slot",
		"cost" : 1000,
		"Use" : "",
		"StoppingPower" : 11,
		"StoppingPower_Cur" : 11
	},
	"Medium Armorjack (Head)" : {
		"tags" : ["armor","equippable","premium","head"],
		"description" : "Heavier Armorjack, with solid plastic plating, reinforced with thicker Kevlar® mesh. Typical Street wear, this combines decent protection with a decent cost.",
		"cost" : 100,
		"Use" : "",
		"StoppingPower" : 12,
		"StoppingPower_Cur" : 12,
		"ArmorPenalty": 1
	},
	"Medium Armorjack (Body)" : {
		"tags" : ["armor","equippable","premium","body"],
		"description" : "Heavier Armorjack, with solid plastic plating, reinforced with thicker Kevlar® mesh. Typical Street wear, this combines decent protection with a decent cost.",
		"cost" : 100,
		"Use" : "",
		"StoppingPower" : 12,
		"StoppingPower_Cur" : 12,
		"ArmorPenalty": 1
	},
	"Heavy Armorjack (Head)" : {
		"tags" : ["armor","equippable","expensive","head"],
		"description" : "The thickest Armorjack, combining denser Kevlar® and a layered  mix of plastic and mesh weaves.",
		"cost" : 500,
		"Use" : "",
		"StoppingPower" : 13,
		"StoppingPower_Cur" : 13,
		"ArmorPenalty": 1
	},
	"Heavy Armorjack (Body)" : {
		"tags" : ["armor","equippable","expensive","body"],
		"description" : "The thickest Armorjack, combining denser Kevlar® and a layered  mix of plastic and mesh weaves.",
		"cost" : 500,
		"Use" : "",
		"StoppingPower" : 13,
		"StoppingPower_Cur" : 13,
		"ArmorPenalty": 1
	},
	"Flak (Head)" : {
		"tags" : ["armor","equippable","expensive","head"],
		"description" : "This is the 21st century version of the time-honored flak vest and pants with metal plates designed to provide protection from high explosive weaponry, artillery, grenades, shotguns, and anti-personnel mines. Modern flak will also stop many of the higher caliber rounds from automatic rifles",
		"cost" : 500,
		"Use" : "",
		"StoppingPower" : 15,
		"StoppingPower_Cur" : 15,
		"ArmorPenalty": 2
	},
	"Flak (Body)" : {
		"tags" : ["armor","equippable","expensive","body"],
		"description" : "This is the 21st century version of the time-honored flak vest and pants with metal plates designed to provide protection from high explosive weaponry, artillery, grenades, shotguns, and anti-personnel mines. Modern flak will also stop many of the higher caliber rounds from automatic rifles",
		"cost" : 500,
		"Use" : "",
		"StoppingPower" : 15,
		"StoppingPower_Cur" : 15,
		"ArmorPenalty": 2
	},
	"Metalgear (Head)" : {
		"tags" : ["armor","equippable","luxury","head"],
		"description" : "You know how Evil Empire Storm Troopers just seem to stand there and take the hit? Metalgear® is the Dark Future equivalent of that type of armor: solid metal and plastic plates on a mesh body cover. Metalgear®will stop almost anything, but you're going to be easier to hit than a one-legged bantha in a potho race",
		"cost" : 5000,
		"Use" : "",
		"StoppingPower" : 18,
		"StoppingPower_Cur" : 18,
		"ArmorPenalty": 2
	},
	"Metalgear (Body)" : {
		"tags" : ["armor","equippable","luxury","body"],
		"description" : "You know how Evil Empire Storm Troopers just seem to stand there and take the hit? Metalgear® is the Dark Future equivalent of that type of armor: solid metal and plastic plates on a mesh body cover. Metalgear®will stop almost anything, but you're going to be easier to hit than a one-legged bantha in a potho race",
		"cost" : 5000,
		"Use" : "",
		"StoppingPower" : 18,
		"StoppingPower_Cur" : 18,
		"ArmorPenalty": 2
	},
	"Bulletproof Shield" : {
		"tags" : ["armor","equippable","premium","hands"],
		"description" : "A transparent polycarbonate shield that can protect you in a firefight.",
		"cost" : 100,
		"Use" : "",
		"HitPoints" : 10,
		"HitPoints_Cur" : 10
	},
	"Light Melee Weapon" : {
		"tags" : ["weapon","melee","costly","standard"],
		"description" : "A light melee weapon, such as a combat knife or tomahawk. Can't do much damage on account of its size, but hey, it's about how you use it. Plus, you can hide it in your pocket.",
		"cost" : 50,
		"Use" : "",
		"damage" : 1,
		"Skill" : "Melee Weapon",
		"ROF" : 2,
		"Hands" : 1,
		"Concealable" : true,
		"WeaponType" : "light melee weapon",
		"Quality" : "Standard"
	},
	"Medium Melee Weapon" : {
		"tags" : ["weapon","melee","costly","standard"],
		"description" : "A medium melee weapon, such as a baseball bat, crowbar, or machete. Simple and reliable, ready to get the job done.",
		"cost" : 50,
		"Use" : "",
		"damage" : 2,
		"Skill" : "Melee Weapon",
		"ROF" : 2,
		"Hands" : 1,
		"Concealable" : false,
		"WeaponType" : "medium melee weapon",
		"Quality" : "Standard"
	},
	"Heavy Melee Weapon" : {
		"tags" : ["weapon","melee","premium","standard"],
		"description" : "A heavy melee weapon, such as a lead pipe, sword, or spiked bat. For when you want people to know you mean business.",
		"cost" : 100,
		"Use" : "",
		"damage" : 3,
		"Skill" : "Melee Weapon",
		"ROF" : 2,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "heavy melee weapon",
		"Quality" : "Standard"
	},
	"Very Heavy Melee Weapon" : {
		"tags" : ["weapon","melee","expensive","standard"],
		"description" : "A very heavy melee weapon, such as a chainsaw, sledgehammer, or naginata. Swings slow, but swings hard.",
		"cost" : 500,
		"Use" : "",
		"damage" : 4,
		"Skill" : "Melee Weapon",
		"ROF" : 1,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "very heavy melee weapon",
		"Quality" : "Standard"
	},
	"Medium Pistol" : {
		"tags" : ["weapon", "ranged", "handgun", "standard", "costly"],
		"description" : "Your average pistol, seen pretty much everywhere and used by everyone.",
		"cost" : 50,
		"Use" : "",
		"damage" : 2,
		"Skill" : "Handgun",
		"ROF" : 2,
		"Hands" : 1,
		"Concealable" : true,
		"WeaponType" : "medium pistol",
		"Quality" : "Standard",
		"MagSize" : 12,
		"MagCur" : 12,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Heavy Pistol" : {
		"tags" : ["weapon", "ranged", "handgun", "standard", "premium"],
		"description" : "A pistol chambered for a larger round, boasting increased firepower at the cost of a smaller magazine.",
		"cost" : 100,
		"Use" : "",
		"damage" : 3,
		"Skill" : "Handgun",
		"ROF" : 2,
		"Hands" : 1,
		"Concealable" : true,
		"WeaponType" : "heavy pistol",
		"Quality" : "Standard",
		"MagSize" : 8,
		"MagCur" : 8,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Very Heavy Pistol" : {
		"tags" : ["weapon", "ranged", "handgun", "standard", "premium"],
		"description" : "Some might say you're compensating for something, but a shot from this oughta shut 'em up real fast.",
		"cost" : 100,
		"Use" : "",
		"damage" : 4,
		"Skill" : "Handgun",
		"ROF" : 1,
		"Hands" : 1,
		"Concealable" : false,
		"WeaponType" : "very heavy pistol",
		"Quality" : "Standard",
		"MagSize" : 8,
		"MagCur" : 8,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"SMG" : {
		"tags" : ["weapon", "ranged", "smg", "standard", "premium"],
		"description" : "Light like a pistol, but capable of spitting out lead a lot faster. Happens to fire the same kind of bullets, too.",
		"cost" : 100,
		"Use" : "",
		"damage" : 2,
		"Skill" : "Handgun",
		"ROF" : 1,
		"Autofire": 3,
		"Hands" : 1,
		"Concealable" : true,
		"WeaponType" : "smg",
		"Quality" : "Standard",
		"MagSize" : 30,
		"MagCur" : 30,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Heavy SMG" : {
		"tags" : ["weapon", "ranged", "smg", "standard", "premium"],
		"description" : "A heavy duty SMG that uses larger bullets and a larger magazine, giving you better stopping power while still remaining compact.",
		"cost" : 100,
		"Use" : "",
		"damage" : 3,
		"Skill" : "Handgun",
		"ROF" : 1,
		"Autofire": 3,
		"Hands" : 1,
		"Concealable" : false,
		"WeaponType" : "heavy smg",
		"Quality" : "Standard",
		"MagSize" : 40,
		"MagCur" : 40,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Shotgun" : {
		"tags" : ["weapon", "ranged", "shotgun", "standard", "expensive"],
		"description" : "Excels in close quarters battle and can use a wide variety of ammunition.",
		"cost" : 500,
		"Use" : "",
		"damage" : 5,
		"Skill" : "Shoulder Arms",
		"ROF" : 1,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "shotgun",
		"Quality" : "Standard",
		"MagSize" : 4,
		"MagCur" : 4,
		"AmmoType" : "Slug",
		"Attachments" : {"slots" : 3}
	},
	"Assault Rifle" : {
		"tags" : ["weapon", "ranged", "assaultRifle", "standard", "expensive"],
		"description" : "A versatile weapon perfect for mid-range combat, and a cornerstone in military armories the world over.",
		"cost" : 500,
		"Use" : "",
		"damage" : 5,
		"Skill" : "Shoulder Arms",
		"ROF" : 1,
		"Autofire" : 4,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "assault rifle",
		"Quality" : "Standard",
		"MagSize" : 25,
		"MagCur" : 25,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Sniper Rifle" : {
		"tags" : ["weapon", "ranged", "sniperRifle", "standard", "expensive"],
		"description" : "A precision weapon best suited for picking off targets at long range. If they're lucky, they'll hear the shot before it hits them.",
		"cost" : 500,
		"Use" : "",
		"damage" : 5,
		"Skill" : "Shoulder Arms",
		"ROF" : 1,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "sniper rifle",
		"Quality" : "Standard",
		"MagSize" : 4,
		"MagCur" : 4,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Bow/Crossbow" : {
		"tags" : ["archery","weapon", "ranged", "bow", "standard", "premium"],
		"description" : "A classic weapon of human history. Don't let its age fool you - in the right hands, this thing's just as deadly as any gun.",
		"cost" : 100,
		"Use" : "",
		"damage" : 4,
		"Skill" : "Archery",
		"ROF" : 1,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "bow",
		"Quality" : "Standard",
		"MagSize" : 1,
		"MagCur" : 1,
		"AmmoType" : "Basic",
		"Attachments" : {"slots" : 3}
	},
	"Grenade Launcher" : {
		"tags" : ["weapon", "ranged", "grenadelauncher", "standard", "expensive", "explosive"],
		"description" : "Can't be bothered clearing a room tactfully? Just chuck a grenade or two in there instead! That's what the grenade launcher's for.",
		"cost" : 500,
		"Use" : "",
		"damage" : 6,
		"Skill" : "Heavy Weapons",
		"ROF" : 1,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "grenade launcher",
		"Quality" : "Standard",
		"MagSize" : 2,
		"MagCur" : 2,
		"AmmoType" : "Armor Piercing",
		"Attachments" : {"slots" : 3}
	},
	"Rocket Launcher" : {
		"tags" : ["weapon", "ranged", "rocketlauncher", "standard", "expensive", "explosive"],
		"description" : "Will blow a vehicle clear off the road or out of the sky. Of course, you can use it on people too for some good ol' overkill.",
		"cost" : 500,
		"Use" : "",
		"damage" : 8,
		"Skill" : "Heavy Weapons",
		"ROF" : 1,
		"Hands" : 2,
		"Concealable" : false,
		"WeaponType" : "rocket launcher",
		"Quality" : "Standard",
		"MagSize" : 1,
		"MagCur" : 1,
		"AmmoType" : "Armor Piercing",
		"Attachments" : {"slots" : 3}
	},
	# The plan for attachments is to include a 'inclusion' and 'exclusion' array. What these do is basically hold tags to be cross-referenced with a weapon's tags to see if the attachment is allowed to be used with that weapon.
	"Bayonet" : {
		"tags" : ["attachment", "premium"],
		"inclusion" : ["ranged","shoulderarms"],
		"exclusion" : ["exotic"],
		"description" : "When wielded, this weapon can also be used as a Light Melee Weapon. While this is attached to a weapon, it cannot be concealed under clothing.",
		"cost": 100,
		"slotsCost": 1,
		"Use" : ""
	},
	"Drum Magazine" : {
		"tags" : ["attachment", "expensive"],
		"inclusion" : ["ranged"],
		"exclusion" : ["exotic", "bow"],
		"description" : "The weapon holds a maximum number of shots equal to its Drum entry on the Clip Chart below. Only one clip can be attached to a weapon at a time. While this is attached to a weapon, it cannot be concealed under clothing.",
		"cost": 500,
		"slotsCost": 1,
		"Use" : ""
	},
	"Extended Magazine" : {
		"tags" : ["attachment", "premium"],
		"inclusion" : ["ranged"],
		"exclusion" : ["exotic", "bow"],
		"description" : "The weapon holds a maximum number of shots equal to its Extended entry on the Clip Chart chart below. Only one clip can be attached to a weapon at a time. While this is attached to a weapon, it cannot be concealed under clothing.",
		"cost": 100,
		"slotsCost": 1,
		"Use" : ""
	},
	"Grenade Launcher Underbarrel" : {
		"tags" : ["attachment", "expensive"],
		"inclusion" : ["ranged", "shoulderarms"],
		"exclusion" : ["exotic"],
		"description" : "When wielded in two hands, the weapon can also be used as a Grenade Launcher, with only 1 grenade in its magazine. While this is attached to a weapon, it cannot be concealed under clothing. Requires 2 Attachment Slots.",
		"cost": 500,
		"slotsCost": 2,
		"Use" : ""
	},
	"Infrared Nightvision Scope" : {
		"tags" : ["attachment", "expensive"],
		"inclusion" : ["ranged"],
		"exclusion" : ["exotic"],
		"description" : "Reduces penalties imposed on your firing at a target obscured to you by darkness, smoke, fog, etc. to 0. Looking through the scope, you can distinguish hot meat from cold metal, but not more specifically than that. You can’t tell the brand of their Cyberarm from a distance, or see any of its internal surprises, for example.",
		"cost": 500,
		"slotsCost": 1,
		"Use" : ""
	},
	"Shotgun Underbarrel" : {
		"tags" : ["attachment", "expensive"],
		"inclusion" : ["ranged","shoulderarms"],
		"exclusion" : ["exotic"],
		"description" : "When wielded in two hands, the weapon can also be used as a Shotgun, with only 2 shots in its magazine. While this is attached to a weapon, it cannot be concealed under clothing. Requires 2 Attachment Slots.",
		"cost": 500,
		"slotsCost": 2,
		"Use" : ""
	},
	"Smartgun Link" : {
		"tags" : ["attachment","expensive"],
		"inclusion" : ["ranged"],
		"exclusion" : ["exotic"],
		"description" : "Installing or uninstalling a Smartgun Link takes an hour. A weapon is a Smartgun only when it has a Smartgun Link attached to it. Special Cyberware is required to take advantage of a Smartgun. A Smartgun Link must be connected to you with Interface Plugs or a Subdermal Grip in order to operate, both of which require you to have a Neural Link. A Subdermal Grip connects a Smartgun held in it automatically. You can plug in Interface Plugs as part of drawing a Smartgun into a free hand, as long as your Interface Plugs aren't already plugged into something else. Being disarmed of your Smartgun doesn't snap your cables, it just unplugs them from the Smartgun. Plugging them back in isn't an Action should you have the Smartgun in your hand, as their ports are designed for ease-of-use. Why go through all this trouble? Because when making Ranged Attacks with one, you add a +1 to your Check.Requires 2 Attachment Slots.",
		"cost": 500,
		"slotsCost": 2,
		"Use" : ""
	},
	"Sniping Scope" : {
		"tags" : ["attachment","premium"],
		"inclusion" : ["ranged"],
		"exclusion" : ["exotic"],
		"description" : "Looking through the scope, user can see detail up to 800m/yds away. When attacking a target 51m/yards or further away with either a weapon's single shot firing mode or an Aimed Shot, you can add a +1 to your Check. Does not stack with TeleOptics Cyberware.",
		"cost": 100,
		"slotsCost": 1,
		"Use" : ""
	}
	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sort the dictionary so we can display items in order
	item_dictionary = Dict_AlphaSort(item_dictionary)
	
	# Testing filter function
	# print(Dict_FilterByTag(item_dictionary,"head"))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Dict_AlphaSort(dict):
	var keys = dict.keys()
	keys.sort()
	var copyDict = {}
	for i in keys.size():
		copyDict[keys[i]] = dict[keys[i]]
	return copyDict

func Dict_FilterByTag(dict, tag):
	var filterDict = {}
	var keys = dict.keys()
	for i in keys.size():
		var tags = dict[keys[i]]["tags"]
		if(tags.has(tag)):
			filterDict[keys[i]] = dict[keys[i]]
	return filterDict
