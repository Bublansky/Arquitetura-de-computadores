.data # define inicia da area de dados do programa
.globl V # define variavel global v[10]
V: # no endereco de v
.word 2,5,6,7,8,9,8,5,4,3 # inicializa com os valores
.globl sum # variavel para armazenar resultado
sum:
.word 0
.text # define inicio da area de programa da memoria
.globl main # define proc main como global
main: # inicio do main
# inicializacoes
sub $sp, $sp,4 # ajusta pilha para guardar 1 word
sw $ra,0($sp) # guarda end de retorno na pilha p caso de proc
# programa que soma elementos do vetor
add $t0,$0,$0 # $t0 sera indice do loop iniciado em 0
lw $t3,sum($0) # $t3 sera acumulo da soma
addi $t4,$0,4 # sera usado para multiplic por 4
ori $t5,$0,10 # sera usado para limite do loop
loop: # inicio do loop
mul $t1,$t0,$t4 # p restricao de alinhamento do vetor v
lw $t2, V($t1) # le v[i] em $t2
add $t3,$t3,$t2 # sum = sum + v[i]
addi $t0,$t0,1 # i = i + 1
bne $t0,$t5, loop # repete loop se i <> 10
sw $t3,sum($0) # salva variavel sum na memoria (sum e variavel global, longe das instrucoes, mas montador SPIM
# resolve o ajuste do endereco colocando instrucoes a mais - VER!)
#finalizacoes
lw $ra,0($sp) # restaura end retorno da pilha
add $sp,$sp,4 # libera pilha
jr $ra # retorna pra quem chamou o programa
