.data # define inicia da area de dados do programa
.globl v # define variavel global v[10]
v: # no endereco de v
.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 # inicializa com os valores
x: # no endereco de x
.word  10, 11, 12, 13, 14, 15, 16, 17, 18, 19 # inicializa com os valores
z: # no endereco de z
.word -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 # inicializa com os valores
#.globl sum # variavel para armazenar resultado
.text # define inicio da area de programa da memoria
.globl main # define proc main como global
main: # inicio do main
# inicializacoes
sub 	$sp, $sp, 4 # ajusta pilha para guardar 1 word
sw 	$ra, 0($sp) # guarda end de retorno na pilha p caso de proc
# programa que soma elementos do vetor
add 	$t0, $0, $0 # $t0 sera indice do loop iniciado em 0
#lw 	$t3, sum($0) # $t3 sera acumulo da soma
addi 	$t4, $0, 4 # sera usado para multiplic por 4
ori 	$t5, $0, 10 # sera usado para limite do loop - vau até 10
loop: # inicio do loop
#lw 	$t3, sum($0) # $t3 sera acumulo da soma
mul 	$t1, $t0, $t4 # p restricao de alinhamento do vetor v
# soma v[i]  com zero
lw 	$t2, v($t1) # le v[i] em $t2
add 	$t3, $0, $t2 # sum = v[i]
#soma x[i] com v[i] em $t3
lw 	$t2, x($t1) # le v[i] em $t2
add 	$t3, $t3, $t2 # sum = sum + x[i]
#armazena a soma z[i] na memoria
sw 	$t3, z($t1)
addi 	$t0, $t0, 1 # i = i + 1
bne 	$t0, $t5, loop # repete loop se i <> 10
#sw 	$t3, sum($0) # salva variavel sum na memoria (sum e variavel global, longe das instrucoes, mas montador SPIM
# resolve o ajuste do endereco colocando instrucoes a mais - VER!)
#finalizacoes
lw 	$ra, 0($sp) # restaura end retorno da pilha
add 	$sp, $sp, 4 # libera pilha
jr 	$ra # retorna pra quem chamou o programa
