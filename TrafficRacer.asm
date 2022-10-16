######################################################################
# CSCB58 Summer 2022 Project
# University of Toronto, Scarborough
#
# Student Name: Maaz Hashmi, Student Number: 1006804718, UTorID: hashmi50
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 (update this as needed)
# - Unit height in pixels: 8 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000
#
# Basic features that were implemented successfully
# - Basic feature a/b/c (choose the ones that apply)
#	a) display number of remaining lives
#	c) display game over screen. restart with retry option

# Additional features that were implemented successfully
# - Additional feature a/b/c (choose the ones that apply)
#  	a) 1 pickup (extra lives)
#	b) display live score (progress bar)
#	c) more challenging level once progress bar is full

# Link to the video demo
# - Insert YouTube/MyMedia/other URL here and make sure the video is accessible
#	https://youtu.be/84bvACxF50g

# Any additional information that the TA needs to know:
# - Write here, if any
#
######################################################################

.data 

screenAddress: .word 0x10008000
playerInitial: .word	0x10008DBC, 0x10008DC0, 0x10008E3C, 0x10008E40, 0x10008EBC, 0x10008EC0
player:	.word	0x10008DBC, 0x10008DC0, 0x10008E3C, 0x10008E40, 0x10008EBC, 0x10008EC0

enemyLeft1: .word 0x10008008, 0x1000800C, 0x10008088, 0x1000808C, 0x10008108, 0x1000810C
enemyLeft2: .word 0x10008008, 0x1000800C, 0x10008088, 0x1000808C, 0x10008108, 0x1000810C
enemyLeft3: .word 0x10008028, 0x1000802C, 0x100080A8, 0x100080AC, 0x10008128, 0x1000812C
enemyLeft4: .word 0x10008028, 0x1000802C, 0x100080A8, 0x100080AC, 0x10008128, 0x1000812C
enemyLeft5: .word 0x10008008, 0x1000800C, 0x10008088, 0x1000808C, 0x10008108, 0x1000810C
enemyLeft6: .word 0x10008028, 0x1000802C, 0x100080A8, 0x100080AC, 0x10008128, 0x1000812C

enemyRight1: .word 0x10008ECC, 0x10008ED0, 0x10008F4C, 0x10008F50, 0x10008FCC, 0x10008FD0
enemyRight2: .word 0x10008ECC, 0x10008ED0, 0x10008F4C, 0x10008F50, 0x10008FCC, 0x10008FD0
enemyRight3: .word 0x10008EE8, 0x10008EEC, 0x10008F68, 0x10008F6C, 0x10008FE8, 0x10008FEC
enemyRight4: .word 0x10008EE8, 0x10008EEC, 0x10008F68, 0x10008F6C, 0x10008FE8, 0x10008FEC
enemyRight5: .word 0x10008ECC, 0x10008ED0, 0x10008F4C, 0x10008F50, 0x10008FCC, 0x10008FD0
enemyRight6: .word 0x10008EE8, 0x10008EEC, 0x10008F68, 0x10008F6C, 0x10008FE8, 0x10008FEC

maxSpeed: .word 50
minSpeed: .word 100

.text

background:

	lw $t0, screenAddress
	add $t2, $zero, $t0
	
dr:	
	li $t1, 0x45474a
	sw $t1, 0($t2)
	addi $t2, $t2, 4
	sub $t3, $t2, $t0
	bgt $t3, 16384, dre
	j dr
	
dre:
	lw $t0, screenAddress
	add $t2, $zero, $t0
	addi $t2, $t2, 60
dy:	
	li $t1, 0xFFB500
	sw $t1, 0($t2)
	addi $t2, $t2, 128
	sub $t3, $t2, $t0
	bgt $t3, 4096, dye
	j dy
	
dye:
	lw $t0, screenAddress
	add $t2, $zero, $zero
	add $t2, $zero, $t0
	addi $t2, $t2, 28
	
dll:	
	li $t1, 0x45474a
        sw $t1, 0($t2)
        sw $t1, 128($t2)
        li $t1, 0xFFFFFF
        sw $t1, 256($t2)
	sw $t1, 384($t2)
	sw $t1, 512($t2)
	addi $t2, $t2, 640
	sub $t3, $t2, $t0
	bgt $t3, 3000, dlle
	j dll

dlle:
	lw $t0, screenAddress
	add $t2, $zero, $zero
	add $t2, $zero, $t0
	addi $t2, $t2, 92
	
dlr:	
	li $t1, 0x45474a
        sw $t1, 0($t2)
        sw $t1, 128($t2)
        li $t1, 0xFFFFFF
        sw $t1, 256($t2)
	sw $t1, 384($t2)
	sw $t1, 512($t2)
	addi $t2, $t2, 640
	sub $t3, $t2, $t0
	bgt $t3, 3000, setup
	j dlr

setup:
		la $t0, player
		li $t2, 0
cleararea:	add $t3, $t0, $t2
		lw $t1, 0($t3)
		li $t4, 0x45474a
		sw $t4, 0($t1)
		addi $t2, $t2, 4
		ble $t2, 20, cleararea	

		la $t1, playerInitial
		li $t2, 0
resetpl:	add $t3, $t0, $t2
		add $t4, $t1, $t2
		lw $t5, 0($t4)
		sw $t5, 0($t3)
		addi $t2, $t2, 4
		ble $t2, 20, resetpl
		
		la $t0, screenAddress
		lw $t1, 0($t0)
		li $t4, 0x45474a
clearS:		sw $t4, 0($t1)
		addi $t1, $t1, 128
		ble $t1, 0x10009000, clearS
		
	li $s1, 3	# lives
	li $s2, 75	# speed
	li $s3, 0	# score
	li $s4, 1	# level
	
main:

newLevel:
	ble $s3, 4096, displayProgress
	li $s4, 2
	li $s3, 0
	la $t0, screenAddress
	lw $t1, 0($t0)
	li $t4, 0x45474a
clearBar:	sw $t4, 0($t1)
		addi $t1, $t1, 128
		ble $t1, 0x10009000, clearBar
	la $t1, maxSpeed
	li $t2, 25
	sw $t2, 0($t1)
	li $s2, 25
	la $t1, minSpeed
	li $t2, 50
	sw $t2, 0($t1)

displayProgress:
	li $t2, 0x1ECBE1
	la $t0, screenAddress
	lw $t0, 0($t0)
	addi $t0, $t0, 4096
	sub $t1, $t0, $s3
	sw $t2, 0($t1)
	
displayLives:
	bge $s1, 1, gr1
	li $t0, 0x45474a
	j drawblock1
gr1:		li $t0, 0x00ff00
drawblock1:	sw $t0, 0x100080F8($zero)

	bge $s1, 2, gr2
	li $t0, 0x45474a
	j drawblock2
gr2:		li $t0, 0x00ff00
drawblock2:	sw $t0, 0x100081F8($zero)
	bge $s1, 3, gr3
	li $t0, 0x45474a
	j drawblock3
gr3:		li $t0, 0x00ff00
drawblock3:	sw $t0, 0x100082F8($zero)
	
	beq $s1, 0, gameOver
	
detectKeyPress:
	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, keypress_happened
	j detectCol

keypress_happened:	
 			lw $t2, 4($t9)
 			beq $t2, 0x61, move_left
 			beq $t2, 0x64, move_right
 			beq $t2, 0x77, speed_up
 			beq $t2, 0x73, slow_down
 			beq $t2, 0x71, exit
 			beq $t2, 0x72, setup
 			j detectCol
 			
slow_down:
		la $t1, minSpeed
		lw $t2, 0($t1)
		addi $s2, $s2, 25
		ble $s2, $t2, sd_exit
		move $s2, $t2
sd_exit:	j detectCol

speed_up:
		la $t1, maxSpeed
		lw $t2, 0($t1)
		addi $s2, $s2, -25
		bgt $s2, $t2, su_exit
		move $s2, $t2
su_exit:	j detectCol

move_left:
		la $t1, player
		
		lw $t0, 4($t1)
		addi $t0, $t0, -128
		lw $t2, 0($t0)
		
		beq $t2, 0x45474a, road1
		beq $t2, 0xFFB500, ylane1

road1:		li $t3, 0x45474a
		j exitc1
ylane1:		li $t3, 0xFFB500
		
exitc1:	 	add $t0, $zero, $zero
ml:		add $t2, $t1, $t0
		lw $t4, 0($t2)
		
		beq $t0, 4, paintr
		beq $t0, 12, paintr
		beq $t0, 20, paintr
		j ignr
		
paintr:		sw $t3, 0($t4)
		
ignr:		addi $t4, $t4, -4
		sw $t4, 0($t2)
		addi $t0, $t0, 4
		ble $t0, 20, ml
		j detectCol
		
move_right:
		la $t1, player
		
		lw $t0, 0($t1)
		addi $t0, $t0, -128
		lw $t2, 0($t0)
		
		beq $t2, 0x45474a, road2
		beq $t2, 0xFFB500, ylane2

road2:		li $t3, 0x45474a
		j exitc2
ylane2:		li $t3, 0xFFB500

exitc2:	 	add $t0, $zero, $zero
mr:		add $t2, $t1, $t0
		lw $t4, 0($t2)
		
		beq $t0, 0, paintl
		beq $t0, 8, paintl
		beq $t0, 16, paintl
		j ignl

paintl:		sw $t3, 0($t4)
		
ignl:		addi $t4, $t4, 4
		sw $t4, 0($t2)
		addi $t0, $t0, 4
		ble $t0, 20, mr
		j detectCol

detectCol:	
		la $t1, player
		
		add $t2, $zero, $zero
pixelLoop:	add $t3, $t1, $t2
		lw  $t4, 0($t3)
		bgt $t4, 0x10008efc, collision
		blt $t4, 0x10008d88, collision
		lw $t5, 0($t4)
		beq $t5, 0xff0000, collision
		beq $t5, 0xff009e, extra_life
		addi $t2, $t2, 4
		ble $t2, 20, pixelLoop
		j drplayer

extra_life:	
		addi $s1, $s1, 1
		j drplayer
		
collision:	
		li $s3, 0
		la $t0, screenAddress
		lw $t1, 0($t0)
		li $t4, 0x45474a
clearScore:	sw $t4, 0($t1)
		addi $t1, $t1, 128
		ble $t1, 0x10009000, clearScore
		
		subi $s1, $s1, 1
		la $t0, player
		li $t2, 0
clear:		add $t3, $t0, $t2
		lw $t1, 0($t3)
		li $t4, 0x45474a
		sw $t4, 0($t1)
		addi $t2, $t2, 4
		ble $t2, 20, clear	

		la $t1, playerInitial
		li $t2, 0
resetpos:	add $t3, $t0, $t2
		add $t4, $t1, $t2
		lw $t5, 0($t4)
		sw $t5, 0($t3)
		addi $t2, $t2, 4
		ble $t2, 20, resetpos
		
drplayer:	
		la $t0, player
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0x0000ff
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR

pickups:
		li $v0, 42
		li $a0, 0
		li $a1, 100
		syscall
		blt $a0, 5, spawn_life
		j no_spawn
spawn_life:	
		li $t0, 0xff009e
		
		li $v0, 42
		li $a0, 0
		li $a1, 4
		syscall
		
		beq $a0, 0, pos0
		beq $a0, 1, pos1
		beq $a0, 2, pos2
		beq $a0, 3, pos3
		
pos0:		li $t1, 0x10008d88
		j spawn	
pos1:		li $t1, 0x10008da8
		j spawn
pos2:		li $t1, 0x10008dcc
		j spawn
pos3:		li $t1, 0x10008de8

spawn:		sw $t0, 0($t1)
		
no_spawn:	ble $s0, 20, ENDFUNCTIONS

drenemies:	
		la $t0, enemyLeft1
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		la $t0, enemyRight1
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		ble $s0, 30, updateLoc
			
		la $t0, enemyLeft2
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		la $t0, enemyRight2
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		ble $s0, 40, updateLoc
		
		la $t0, enemyLeft3
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		la $t0, enemyRight3
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		ble $s0, 50, updateLoc

		la $t0, enemyLeft4
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		la $t0, enemyRight4
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		ble $s0, 60, updateLoc
		
		la $t0, enemyLeft5
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		la $t0, enemyRight5
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		ble $s0, 70, updateLoc
			
		la $t0, enemyLeft6
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
		la $t0, enemyRight6
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		li $t1, 0xff0000
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		jal DRAWCAR
		
updateLoc:	
		la $t0, enemyLeft1
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCLEFT
		
		la $t0, enemyRight1
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCRIGHT
		
		ble $s0, 30, sleep
		
		la $t0, enemyLeft2
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCLEFT
		
		la $t0, enemyRight2
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCRIGHT
		
		ble $s0, 40, sleep
		
		la $t0, enemyLeft3
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCLEFT
		
		la $t0, enemyRight3
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCRIGHT
		
		ble $s0, 50, sleep
		
		la $t0, enemyLeft4
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCLEFT
		
		la $t0, enemyRight4
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCRIGHT
		
		ble $s0, 60, sleep
		
		la $t0, enemyLeft5
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCLEFT
		
		la $t0, enemyRight5
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCRIGHT
		
		ble $s0, 70, sleep

		la $t0, enemyLeft6
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCLEFT
		
		la $t0, enemyRight6
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		jal UPDATEENEMYLOCRIGHT
		
		j ENDFUNCTIONS

	##### FUNCTIONS ####
DRAWCAR:	
		lw $t3, 0($sp)
		addi $sp, $sp, 4 	# pop color
		
		lw $t1, 0($sp)
		addi $sp, $sp, 4 	# pop location array 
		
		add $t0, $zero, $zero 	# clear counter
dc:	
		# draw six pixels at locations in the array of given color
		add $t2, $t1, $t0
		lw $t4, 0($t2)
		sw $t3, 0($t4)
		addi $t0, $t0, 4
		ble $t0, 20, dc
		jr $ra
		
UPDATEENEMYLOCLEFT:
		lw $t1, 0($sp)
		addi $sp, $sp, 4 	# pop location array 
		
		# paint 2 pixels above gray
		li $t3, 0x45474a
		lw $t2, 0($t1)
		sw $t3, -128($t2)
		sw $t3, -256($t2) 
		lw $t2, 4($t1)
		sw $t3, -128($t2)
		sw $t3, -256($t2) 
		
		# update location to move down 2 pixels
		add $t0, $zero, $zero
update1:	add $t2, $t1, $t0
		lw $t4, 0($t2)
		addi $t4, $t4, 128
		sw $t4, 0($t2)
		addi $t0, $t0, 4
		ble $t0, 20, update1
		
		# if reached bottom of screen, reset position to top
		la $t9, screenAddress
		lw $t9, 0($t9)
		subi $t4, $t4, 384
		sub $t9, $t4, $t9
		ble $t9, 4096, ret1
		
		add $t0, $zero, $zero
reset1:		add $t2, $t1, $t0
		lw $t4, 0($t2)
		subi, $t4, $t4, 4096
		sw $t4, 0($t2)
		addi $t0, $t0, 4
		ble $t0, 20, reset1
		
ret1:		jr $ra


UPDATEENEMYLOCRIGHT:
		lw $t1, 0($sp)
		addi $sp, $sp, 4 	# pop location array 
		
		# paint 2 pixels below gray
		li $t3, 0x45474a
		lw $t2, 16($t1)
		sw $t3, 128($t2)
		sw $t3, 256($t2) 
		lw $t2, 20($t1)
		sw $t3, 128($t2)
		sw $t3, 256($t2) 
		
		# update location to move up 2 pixels
		add $t0, $zero, $zero
update2:	add $t2, $t1, $t0
		lw $t4, 0($t2)
		addi $t4, $t4, -128
		sw $t4, 0($t2)
		addi $t0, $t0, 4
		ble $t0, 20, update2
		
		# if reached top of screen, reset position to bottom
		la $t9, screenAddress
		lw $t9, 0($t9)
		sub $t9, $t9, $t4
		ble $t9, 384, ret2
		
		add $t0, $zero, $zero
reset2:		add $t2, $t1, $t0
		lw $t4, 0($t2)
		addi, $t4, $t4, 4096
		sw $t4, 0($t2)
		addi $t0, $t0, 4
		ble $t0, 20, reset2
		
ret2:		jr $ra

ENDFUNCTIONS:
	
sleep:
	li $v0, 32
	move $a0, $s2
	syscall
	
	addi $s0, $s0, 1
	
	li $t0 10
	divu $s0, $t0
	mfhi $t3
	bnez $t3, jump
	beq $s4, 2, jump
	addi $s3, $s3, 128
	
jump:	j main

gameOver:
	lw $t0, screenAddress
	add $t2, $zero, $t0
	
black:	
	li $t1, 0x45474a
	sw $t1, 0($t2)
	addi $t2, $t2, 4
	sub $t3, $t2, $t0
	bgt $t3, 16384, prompt
	j black

prompt:
	li $t9, 0xffff0000
	lw $t8, 0($t9)
	beq $t8, 1, kh
	j prompt

kh:	
 	lw $t2, 4($t9)
 	beq $t2, 0x71, exit
 	beq $t2, 0x72, background
 	j kh

exit:
	li $v0, 10
	syscall
