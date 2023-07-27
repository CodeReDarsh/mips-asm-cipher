.text
null_cipher_sf:
	#la $a0, plaintext1
	#la $a1, ciphertext1
	#la $a2, indices1
	#lw $a3, num_indices1
	#plaintext: points to an uninitialized buffer with sufficient space to store the decrypted ciphertext
	#ciphertext: a null-terminated string that contains a message encrypted by the null cipher described earlier
	#indices: an array of 1-based letter indices needed to extract words from the ciphertext
	#num_indices: the number of values in indices
	
	li $t0, 0	#t0 = plaintxt counter = 0
	li $t1, 0	#t1 = loop1 counter = 0
	li $t2, ' '	# t2 = ' ' (whitespace checker)
	
	loop1: 	#loop through the indices1
		beq $t1, $a3, loop1.end		# branch if t1 = a3
		lw $t3, 0($a2)			# t3 = indicies[i] (offset for a1(cipher text))
		beqz $t3, loop2			# branch if t3 = 0
		addi $t3, $t3, -1		# t3 = t3 - 1
		
		add $a1, $a1, $t3		# a1 = a1 + t3(offset)
		lbu $t4, 0($a1)			# t4 = ciphertext[i]
		sb $t4, 0($a0)			# plaintext[0] = t4
		addi $a0, $a0, 1		# plaintext = plaintext + 1
		addi $t0, $t0, 1		# t0++
		
		loop2:	#loop through the ciphertext1
			lbu $t5, 0($a1)
			beq $t5, $t2, loop2.end		#branch if t5 = t2 = ' '
			beq $t5, $zero, loop1.end	#branch if t5 = null terminator
			addi $a1, $a1, 1
			j loop2	
			
		loop2.end:
		
		addi $a1, $a1, 1
		addi $a2, $a2, 4
		addi $t1, $t1, 1
		j loop1
		 
	loop1.end:
	sb $zero, 0($a0)
	move $v0, $t0
	
	jr $ra

transposition_cipher_sf:
	#la $a0, plaintext1
	#la $a1, ciphertext1
	#lw $a2, nr1
	#lw $a3, nc1
	#plaintext: points to an uninitialized buffer with sufficient space to store the decrypted ciphertext
	#ciphertext: a null-terminated string that contains a message encrypted by the transposition cipher described earlier
	#num_rows: the number of rows in the grid used to encrypt the plaintext
	#num_cols: the number of columns in the grid used to encrypt the plaintext
	
	li $t0, 0		# t0 = 0 = tloop1 counter
	
	li $t2, '*'		
	
	tloop1:
		beq $t0, $a2, tloop1.end
		move $t3, $a1	# row offsetter
		li $t1, 0	# t1 = 0 = tloop2 counter
		
		tloop2:
			beq $t1, $a3, tloop2.end
			lbu $t4, 0($t3)
			beq $t4, $t2, tloop1.end
			sb $t4, 0($a0)
			
			addi $a0, $a0, 1
			add $t3, $t3, $a2
			addi $t1, $t1, 1
			j tloop2
			
		tloop2.end:
		
		addi $a1, $a1, 1
		addi $t0, $t0, 1
		j tloop1
		
	tloop1.end:
	
	
	sb $zero, 0($a0)
	jr $ra

decrypt_sf:
	#la $a0, plaintext1
	#la $a1, ciphertext1
	#lw $a2, nr1
	#lw $a3, nc1
	#addi $sp, $sp, -8
	#la $t7, indices1
	#sw $t7, 4($sp)
	#lw $t7, num_indices1
	#sw $t7, 0($sp)
	
	move $fp, $sp	#save original sp before allocating memory on the stack
	move $t7, $ra	#save original return address in t7 before having it changed
	move $t8, $a0	#save the original plain text's address in t8
	
	mul $t0, $a2, $a3	#obtain string length of transpose decrypt plain text by mul rows and colums and store that in t0
	li $t1, -1
	mul $t0, $t0, $t1
	
	add $sp, $sp, $t0	#space created for new plain text of trans decpt
	move $a0, $sp 		# a0 = current sp (trans decpt plain text)
	move $t9, $sp
	jal transposition_cipher_sf
	
	move $a1, $t9
	move $a0, $t8
	lw $a2, 4($fp)
	lw $a3, 0($fp)
	jal null_cipher_sf
	
	
	move $sp, $fp
	move $ra, $t7
	jr $ra

