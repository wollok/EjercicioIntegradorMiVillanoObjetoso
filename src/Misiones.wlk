import Villano.*

object sinMinionsAsignados inherits Exception {}

class Maldad {
	
	const minionsAsignados=[]
	
	method asignarMinions(minions){
		minionsAsignados.addAll(minions)
	}
	
	method minionsAsignados() = minionsAsignados
		
	method realizar(ciudad){
		if(minionsAsignados.isEmpty())
			throw sinMinionsAsignados 
		self.realizarEn(ciudad)
		minionsAsignados.forEach{minion=>self.realizarCon(minion) minion.agregarMaldad()}
	}
	method realizarEn(ciudad)
	method realizarCon(minion) 
	method esApto(minion)
}

class Congelar inherits Maldad{
	var nivelMinimo = 500
	
	override 
	method realizarEn(ciudad){
		ciudad.reducirTemperatura(30)
	}
	override
	method realizarCon(minion){
		minion.alimentar(10)
	}
	override
	method esApto(minion) = 
		minion.tieneArma("Rayo Congelante")
		&& minion.nivelConcentracion() > nivelMinimo 

}

class Robar inherits Maldad{
	var objetivo
	
	constructor(_objetivo){
		objetivo = _objetivo
	}
	override 
	method realizarEn(ciudad){
		ciudad.eliminar(objetivo)
	}
	override
	method realizarCon(minion){
		objetivo.realizarCon(minion)
	}
	override
	method esApto(minion) = 
		minion.esPeligroso()
		&& objetivo.esApto(minion)

}

class Piramide{
	var altura
	constructor(_altura) {altura = _altura}

	method esApto(minion) = 
		minion.nivelConcentracion() > altura/2 
			
	method realizarCon(minion){
		minion.alimentar(10)
	}

}

object luna {
	method esApto(minion) = 
		minion.tieneArma("Rayo para encoger") 
			
	method realizarCon(minion){
		minion.otorgarArma(new Arma("Rayo Congelante",10))
	}

}

object sueroMutante{

	method esApto(minion) = 
		minion.nivelConcentracion() > 23
		&& minion.bananas()>100 
			
	method realizarCon(minion){
		minion.consumirSueroMutante()
	}
	
}


class Ciudad {
	var temperatura
	var maravillas
	constructor(temp,marav){
		temperatura = temp
		maravillas = marav
	}
	
	method temperatura() = temperatura

	method reducirTemperatura(t){
		temperatura -= t
	}
	
	method objetosQueTiene()= maravillas

	method eliminar(elemento){
		maravillas.remove(elemento)
	}
	method tieneMaravilla(elemento)= maravillas.contains(elemento)
	
}
	