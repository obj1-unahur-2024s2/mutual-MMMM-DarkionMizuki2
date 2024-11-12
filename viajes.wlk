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
  method esRecomendablePara(unSocio)=self.esInteresante() and unSocio.leAtrae(self) and not unSocio.actividadesQueRealizo().count({a => a==self})>1
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
-----------------------------------------
PARTE 6
3. Clases de gimnasia
Agregar al modelo las clases de gimnasia, que son otro tipo de actividad que la mutual ofrece a sus socios.

Se deben resolver las mismas cuatro preguntas que para los viajes, que se responden así:

idiomas: en las clases de gimnasia se usa únicamente español.
Llevan 1 día.
Siempre implican esfuerzo, y nunca sirven para broncearse.
*/
class ClasesDeGimnasia inherits Viaje{
  override method idiomas()=["español"]
  override method cuantosDiasLlevaLaActividad()=1
  override method implicaEsfuerzo()=true
  override method esParaBrocearse()=false
  override method esRecomendablePara(unSocio)=unSocio.edad()>20 and unSocio.edad()<30
}
/*
PARTE 7
4. Socios, agregar actividad
Agregar al modelo los socios. De cada socio se debe registrar qué actividades realizó, 
que pueden ser viajes o clases de gimnasia. Para cada socio se establece también un máximo de actividades que puede hacer.

Se debe resolver, para un socio:

si es, o no, adorador del sol. La condición es que todas actividades que realizó sirven para broncearse.
la colección de actividades esforzadas, o sea, las actividades que realizó que implican esfuerzo.
registrar que realiza una actividad. Si ya llegó al máximo de actividades que puede hacer, hay que lanzar error.
P.ej. tomemos a Roque, un socio que hizo 2 viajes a la playa, con longitudes de 1000 y 2000 metros respectivamente, 
y que tiene un máximo de 2 actividades. En este caso:

roque.esAdoradorDelSol() devuelve true.
roque.actividadesEsforzadas() devuelve una colección que tiene solamente el viaje de 2000 metros de playa.
si registramos que Roque realiza una clase de gimnasia, se debe generar un error.
Si Ana es una socia que hizo dos viajes iguales a los que hizo Roque, pero tiene un máximo de 3 actividades, 
entonces sí le podemos registrar una clase de gimnasia. Después de registrarla, obtenemos que Ana ya no es adoradora del 
sol, y su colección de actividades esforzadas incluye al viaje de 2000 metros de playa y a la clase.
*/
class Socio{
  const nombre
  const property actividadesQueRealizo //pueden ser viajes o clases de gimnasia
  const maximoDeActividadesQuePuedeRealizar
  const property edad
  const idiomasQueHabla
  method esAdoradorDelSol()=actividadesQueRealizo.all({unaA => unaA.esParaBrocearse()})
  method actividadesEsforzadas()=actividadesQueRealizo.filter({unaA => unaA.implicaEsfuerzo()})
  method registrarActividad(unaActividad){
    if(actividadesQueRealizo.size()<maximoDeActividadesQuePuedeRealizar){
      actividadesQueRealizo.add(unaActividad)
    }else{
      self.error(nombre+" no puede realizar mas de "+maximoDeActividadesQuePuedeRealizar+" viajes!")
    }
  }
  method hablaMasDeUnIdioma()=idiomasQueHabla.size()>1
}
/*
PARTE 8
5. Actividades que le atraen a cada socio
Se debe agregar al modelo la pregunta de si una actividad le atrae a un socio o no.
Para ello, se debe agregar para cada socio, la edad, y la colección de idiomas que habla (en realidad, la edad se usa 
recién en el punto siguiente, pero cuesta poco agregarla ahora).
La condición depende del tipo de socio, de acuerdo a lo siguiente:

si es un socio tranquilo, entonces la condición es que la actividad lleve 4 días o más.
si es un socio coherente, entonces: si es adorador del sol, entonces la actividad debe servir para broncearse, 
si no, debe implicar esfuerzo.
si es un socio relajado, la condición es hablar al menos uno de los idiomas que se usan en la actividad. 
P.ej. si un socio relajado habla español y quechua, entonces una actividad en español le va a atraer, una en quechua 
y aymará también, una en francés e italiano no.
*/
class SocioTranquilo inherits Socio{
  method leAtrae(unaActividad){
    return unaActividad.cuantosDiasLlevaLaActividad()>=4
  }
}
class SocioCoherente inherits Socio{
  method leAtrae(unaActividad){
    return if(self.esAdoradorDelSol()) unaActividad.esParaBrocearse() else unaActividad.implicaEsfuerzo()
  }
}

class SocioRelajado inherits Socio{
  method leAtrae(unaActividad){
    return idiomasQueHabla.any({
      unIQueHabla => unaActividad.idiomas().contains(unIQueHabla)
    })
  }
}
/*
PARTE 9
6. Actividades recomendadas para socios
Agregar la posibilidad de preguntar, para una actividad, si es recomendada para un socio o no.

Para los viajes, se deben cumplir tres condiciones: que la actividad sea interesante, que le atraiga al socio, y que el socio no haya realizado ya la misma actividad.

Para las clases de gimnasia, la condición es que el socio tenga entre 20 y 30 años.
----------------------
PARTE 10
Bonus: taller literario
Agregar un nuevo tipo de actividad: el taller literario. De cada taller se registra sobre qué libros se trabaja. De cada libro se conoce: el idioma, la cantidad de páginas, y el nombre del autor.

Para un taller literario tenemos:

idiomas usados: los de los libros que se trabajan.
días que lleva: la cantidad de libros más uno.
implica esfuerzo: si incluye al menos un libro de más de 500 páginas, o bien todos los libros son del mismo autor, y hay más de uno.
sirve para broncearse: nunca.
es recomendado para un socio: la condición es que el socio hable más de un idioma.
*/
class TallerLiterario inherits Viaje{
  const property librosQueTrabaja
  override method idiomas()=librosQueTrabaja.map({l => l.idioma()})
  override method cuantosDiasLlevaLaActividad()=librosQueTrabaja.size()+1
  override method implicaEsfuerzo()=(self.tieneAlMenosUnLibroMasDe500Pag() or self.losLibrosSonDelMismoAutor() ) and
    self.hayMasDeUnLibro()
  method losLibrosSonDelMismoAutor()=librosQueTrabaja.forEach({
    l1 => self.librosQueTrabaja().all({ l2 => l2.nombreDelAutor()==l1.nombreDelAutor() })
  })
  method tieneAlMenosUnLibroMasDe500Pag()=librosQueTrabaja.any({ unLibro => unLibro.cantidadDePaginas() > 500 })
  method hayMasDeUnLibro()=librosQueTrabaja.size()>1
  override method esParaBrocearse()=false
  override method esRecomendablePara(unSocio)=unSocio.hablaMasDeUnIdioma()
}

class Libro{
  const property idioma
  const property cantidadDePaginas
  const property nombreDelAutor
}