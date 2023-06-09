[top]
components : corazona 

[corazona]
type : cell
dim : (5,5)
delay : transport
defaultDelayTime  : 5
border : nowrapped
neighbors : corazona(-1,-1) corazona(-1,0) corazona(-1,1) 
neighbors : corazona(0,-1)  corazona(0,0)  corazona(0,1)
neighbors : corazona(1,-1)  corazona(1,0)  corazona(1,1)  
initialvalue : -85.0
initialCellsValue : corazona.val
localtransition : corazona-rule

[corazona-rule]
%La funcion setArg es para setear parametros en una celda.
%La funcion getArg es para obtener parametros de una celda.
%Ambas reciben las coordenadas de la celda y el nro de parametro en cuetion.

%Parámetros:
%0)Voltaje actual de la celda 
%1)Estado de la celda (reposo o activa)
%2)Factor de discretizacion de la funcion original APA
%3)Quantum utilizado (10 en este ejemplo)
%Luego se setea otro parametro que es el delay para 
%llegar al proximo q que es lo que devuelve APAINV
%y la funcion APAINV setea otro parametro mas que es 
%el valor que toma la funcion APA en el tiempo calculado (luego del delay)

%La siguiente regla, que ejecuta 1ro la condicion (true en este caso),
%Luego el delay (que es cuando calculo el delay hasta el proximo q y
%la funcion internamente setea el voltaje con el que llego al proximno q
%y luego actualiza el valor de la celda con el parametro 5 
%seteado por la funcion APAINV


rule : { getArg(cellpos(0)*100000+cellpos(1)*100+5) } 
{ 
    setArg(cellpos(0)*100000+cellpos(1)*100+0,(0,0))+
    setArg(cellpos(0)*100000+cellpos(1)*100+1, if((0,0)=-83.0,1.0,0.0) )+
    setArg(cellpos(0)*100000+cellpos(1)*100+2,0.025)+
    setArg(cellpos(0)*100000+cellpos(1)*100+3,10)+
    setArg(cellpos(0)*100000+cellpos(1)*100+4, APAINV(cellpos(0),cellpos(1)))+
    getArg(cellpos(0)*100000+cellpos(1)*100+4) / 0.025 * 5 
} { t }
