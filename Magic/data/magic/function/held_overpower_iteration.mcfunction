scoreboard players operation Temp reg_1 = @s player_id
execute as @a[tag=using,tag=can_use] if score @s player_id = Temp reg_1 run scoreboard players operation @s current_held -= Temp reg_2