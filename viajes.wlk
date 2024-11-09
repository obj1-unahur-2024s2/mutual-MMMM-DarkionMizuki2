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
--------------------------------------------------
*/
class ViajeDePlaya inherits Viaje{
  const largo //medido en metros.
  override method cuantosDiasLlevaLaActividad()=largo/500
  override method implicaEsfuerzo()=largo>1200
  override method esParaBrocearse()=true
}