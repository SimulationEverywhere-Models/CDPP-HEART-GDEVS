[top]
components : heart-GDEVS 

[heart-GDEVS]
type : cell
dim : (5,5,2)
delay : transport
defaultDelayTime  : 1
border : nowrapped
neighbors : (0,-1,0) (0,0,0) (-1,0,0) (-1,-1,0) 
neighbors : (0,1,0)  (1,0,0) (-1,1,0) (1,1,0) (1,-1,0) (0,0,1)
initialvalue : -83.0
initialCellsValue : corazon.val
localtransition : heart-rule-GDEVS

[heart-rule-GDEVS]
%Calculo del Voltage segun los coeficientes (depende del estado del 2do plano)
%y del tiempo en el que se activo cada celda ( getArg(0) )

%Esta regla tiene delay 0, pues recalculo cuando cambia el indice del coeficiente o sus vecinas

rule : 	{ 
if( (0,0,1) = -83.0, (0,0,0), 0.0 ) +
if( (0,0,1) = -1, -85.0, 0.0 ) +
if( (0,0,1) = 0, 1.0250  * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) - 83.1478, 0.0 ) +
if( (0,0,1) = 1, 6.4555  * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) - 275.5886, 0.0 ) +
if( (0,0,1) = 2, -0.2765 * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) + 37.47, 0.0 ) +
if( (0,0,1) = 3, -0.0661 * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) + 8.784, 0.0 ) +
if( (0,0,1) = 4, -0.0073 * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) - 8.6492, 0.0 ) +
if( (0,0,1) = 5, -0.0022 * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) - 12.1344, 0.0 ) +
if( (0,0,1) = 6, -0.0143 * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) + 10.6898, 0.0 ) +
if( (0,0,1) = 7, -0.0016 * ( time - getArg(cellpos(0)*100000+cellpos(1)*100 + 0) ) - 64.0617, 0.0 ) +
if( (0,0,1) = 8, -83.0, 0.0 )
 } 0 { cellpos(2) = 0 }

%ESTA PARTE SETEA QUE COEFICIENTES USAR EN CADA MOMENTO PARA CADA CELDA
rule : 	{ -1 } {1 + setArg(cellpos(0)*100000+cellpos(1)*100 + 0, time) } { (0,0,0) = -83.0 and ( (0,-1,0) = 2 or (-1,-1,0) = 2 or (-1,0,0) = 2 or (cellpos(0)=0 and cellpos(1)=0) ) and cellpos(2) = 1 }
rule : 	{ 0 } 1 { (0,0,0) = -1 and cellpos(2) = 1 }
rule : 	{ 1 } 35 { (0,0,0) = 0 and cellpos(2) = 1 }
rule : 	{ 2 } 8 { (0,0,0) = 1 and cellpos(2) = 1 }
rule : 	{ 3 } 5 { (0,0,0) = 2 and cellpos(2) = 1 }
rule : 	{ 4 } 100 { (0,0,0) = 3 and cellpos(2) = 1 }
rule : 	{ 5 } 100 { (0,0,0) = 4 and cellpos(2) = 1 }
rule : 	{ 6 } 750 { (0,0,0) = 5 and cellpos(2) = 1 }
rule : 	{ 7 } 750 { (0,0,0) = 6 and cellpos(2) = 1 }
rule : 	{ -83.0 } 9250 { (0,0,0) = 7 and cellpos(2) = 1 }
rule : 	{ (0,0,0) } 0 { (0,0,0) = -83.0 and ( (0,-1,0) != 2 and (-1,-1,0) != 2 and (-1,0,0) != 2 ) and cellpos(2) = 1 }
