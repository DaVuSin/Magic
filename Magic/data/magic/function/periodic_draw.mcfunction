#Get positive/negative distance from 32
execute store result score @s reg_1 run clear @s minecraft:ender_eye 0
#Need old copy
scoreboard players operation @s reg_2 = @s reg_1

scoreboard players remove @s[scores={reg_2=32..}] reg_1 32
scoreboard players remove @s[scores={reg_2=..31}] reg_1 32

#Increase
execute as @s[scores={reg_1=1..}] run scoreboard players operation Draw_force reg_1 = @s reg_1
execute as @s[scores={reg_1=1..}] run function magic:draw_multiple

#Decrease (+&-=-)
scoreboard players operation @s reg_1 *= 10 reg_1
execute as @s[scores={reg_1=..-1}] run scoreboard players operation @s current_held += @s reg_1

#Self draw
#Circled/Angreal prevents the problem of exponential growth

#At 1:1
#Self draw increase: 1
execute as @s[tag=!circle_owner,tag=!angrealed,scores={progressive_shielded=0,halve_amount_hold=10..}] if score @s current_held > @s cumulative_halve_amount_hold run give @s minecraft:ender_eye[enchantment_glint_override=1b,custom_name='[{"text":"Force","italic":false,"color":"dark_purple"}]',lore=['[{"text":"Force","italic":false}]'],custom_model_data=0,custom_data={Force:6}] 1

#At 2:1
#Self draw increase: 4
scoreboard players operation @s reg_1 = @s cumulative_halve_amount_hold
scoreboard players operation @s reg_1 += @s cumulative_halve_amount_hold
execute as @s[tag=!circle_owner,tag=!angrealed,scores={progressive_shielded=0,halve_amount_hold=10..}] if score @s current_held > @s reg_1 run give @s minecraft:ender_eye[enchantment_glint_override=1b,custom_name='[{"text":"Force","italic":false,"color":"dark_purple"}]',lore=['[{"text":"Force","italic":false}]'],custom_model_data=0,custom_data={Force:6}] 4

#At 4:1
#Self draw decrease: -12 Makes it harder to blow up
scoreboard players operation @s reg_1 += @s cumulative_halve_amount_hold
scoreboard players operation @s reg_1 += @s cumulative_halve_amount_hold
execute as @s[tag=!circle_owner,tag=!angrealed,scores={progressive_shielded=0,halve_amount_hold=10..}] if score @s current_held > @s reg_1 run clear @s minecraft:ender_eye 12

#Lost hold of it
execute as @s[scores={current_held=..0}] run function magic:exit

#tellraw @a {"score":{"name":"@s","objective":"reg_1"}}