#Make damage size^3
$scoreboard players set Temp reg_1 $(size)

scoreboard players operation Temp reg_2 = Temp reg_1
scoreboard players operation Temp reg_2 *= Temp reg_1
scoreboard players operation Temp reg_2 *= Temp reg_1

execute store result storage magic:damage amount int 1 run scoreboard players get Temp reg_2

$execute at @s as @e[distance=..$(size)] run function magic:actions/damage with storage magic:damage
summon lightning_bolt
tag @s add weave_damaged