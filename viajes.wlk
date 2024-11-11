/*
1. Viajes
En este punto se nos pide modelar los viajes que la mutual ofrece a sus socios.

De cada viaje se tienen que poder preguntar cuatro cosas:

.idiomas que se usan durante el viaje.
.si hacer el viaje implica esfuerzo o no.
.si el viaje sirve para broncearse o no.
.cuántos días lleva la actividad.
*/
class Viaje{
  var property idiomas //["Español","Italiano"]
  method implicaEsfuerzo()
  method esParaBrocearse()
  method cuantosDiasLlevaLaActividad()
  method esInteresante()=idiomas.size()>1
}

/*
Los idiomas se informan explícitamente para cada viaje. Cada idioma se puede representar como un String,
p.ej. "español" o "italiano".
El resto de la información requerida depende del tipo de viaje
--------------------------------------------------
PARTE 2
Viajes de playa.
De cada viaje de playa se informa el largo de la playa, medido en metros. 
Para calcular cuántos días lleva un viaje de playa, se hace esta cuenta: largo / 500. Un viaje de playa implica esfuerzo 
si el largo de la playa supera los 1200 metros. Todos los viajes de playa sirven para broncearse.
*/
class ViajeDePlaya inherits Viaje{
  const largo //medido en metros.
  override method cuantosDiasLlevaLaActividad()=largo/500
  override method implicaEsfuerzo()=largo>1200
  override method esParaBrocearse()=true
}
/*
--------------------------------------------------
PARTE 3
Excursión a ciudad
De cada excursión a ciudad se informa cuántas atracciones se van a visitar. 
Los días que lleva un viaje de este tipo se calculan como cantidad de atracciones / 2. 
Una excursión implica esfuerzo si se visitan entre 5 y 8 atracciones, y nunca sirve para broncearse.

Un caso especial son las excursiones a ciudad tropical. Son como las excursiones a ciudad, 
con las siguientes variantes: dura un día más que una excursión a ciudad de las mismas características, 
y sí sirve para broncearse, siempre.

P.ej.:

una excursión a ciudad normal (no tropical) en la que se visitan 4 atracciones, lleva 2 días, no implica esfuerzo, 
y no sirve para broncearse.
una excursión a ciudad tropical en la que se visitan 4 atracciones, lleva 3 días, no implica esfuerzo, 
y sí sirve para broncearse.
una excursión a ciudad normal (no tropical) en la que se visitan 8 atracciones, lleva 4 días, implica esfuerzo, 
y no sirve para broncearse.
una excursión a ciudad tropical en la que se visitan 8 atracciones, lleva 5 días, implica esfuerzo, 
y sirve para broncearse.
una excursión a ciudad tropical en la que se visitan 10 atracciones, lleva 6 días, no implica esfuerzo, 
y sí sirve para broncearse.
--------------------------------------------------
*/
class ExcursionACiudad inherits Viaje{
  const cantidadDeAtraccionesQueSeVanAVisitar
  override method cuantosDiasLlevaLaActividad()=cantidadDeAtraccionesQueSeVanAVisitar/2
  override method implicaEsfuerzo()=valor.unNumero_estaEntre(cantidadDeAtraccionesQueSeVanAVisitar,5,8)
  override method esParaBrocearse()=false
  override method esInteresante()=super() or cantidadDeAtraccionesQueSeVanAVisitar==5
}

class ExcursionACiudadTropical inherits ExcursionACiudad{
  override method cuantosDiasLlevaLaActividad()=super()+1
  override method esParaBrocearse()=true
}

object valor{
  method unNumero_estaEntre(n,a,b){
    return n>=a and n<=b
  }
}
/*
PARTE 4
Salida de trekking
De cada salida de trekking se conoce cuántos kilómetros de senderos se van a recorrer caminando, 
y cuántos días de sol por año tiene el lugar donde se va a hacer.
Los días que lleva una salida se calculan como kilometros de senderos / 50. 
Una salida implica esfuerzo si se recorren más de 80 kilómetros, y sirve para broncearse si en el lugar hay más de 200 días
de sol por año, o hay entre 100 y 200, y se recorren más de 120 kilómetros.

P.ej.

una salida de 100 kilómetros a un lugar con 130 días de sol por año: lleva 2 días, implica esfuerzo, y no sirve para broncearse.
una salida de 50 kilómetros a un lugar con 240 días de sol por año: lleva 1 día, no implica esfuerzo, y sí sirve para broncearse.
una salida de 250 kilómetros a un lugar con 130 días de sol por año: lleva 5 días, implica esfuerzo, y sirve para broncearse.
*/
class SalidaDeTrekking inherits Viaje{
  const kilometrosDeSenderos
  const diasDeSolEnElLugarQueSeVaHacer //por año
  override method cuantosDiasLlevaLaActividad()=kilometrosDeSenderos/50
  override method implicaEsfuerzo()=kilometrosDeSenderos>80
  override method esParaBrocearse()=(diasDeSolEnElLugarQueSeVaHacer>200 or 
                    valor.unNumero_estaEntre(diasDeSolEnElLugarQueSeVaHacer,100,200))
                    and kilometrosDeSenderos>120
  override method esInteresante()=super() and diasDeSolEnElLugarQueSeVaHacer>140
}
/*
PARTE 5
2. Viajes interesantes
Agregar al modelo la capacidad de preguntar si un viaje es interesante. Por lo general, 
la condición es que se use más de un idioma, p.ej. quechua y aymara, o francés, alemán y húngaro. 
Hay que contemplar estas variantes:

las excursiones a ciudad (tropical o no) se consideran interesantes si se cumple la condición general, o bien, 
se recorren exactamente 5 atracciones (ni más ni menos, exactamente 5).
las salidas de trekking se consideran interesantes si se cumple la condición general, y además en el lugar hay más de 140 
días de sol por año.
*/