import Villano.*

object sinMinionsAsignados inherits Exception {}

class Maldad {
	
	const property minionsAsignados=[]
	
	method asignarMinions(minions){
		minionsAsignados.addAll(minions)
	}
			
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
	var property nivelMinimo = 500
	
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
	var property objetivo
	
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
	var property altura

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
		minion.otorgarArma(new Arma(nombre = "Rayo Congelante",poder = 10))
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
	var property temperatura
	var property maravillas
	
	method temperatura() = temperatura

	method reducirTemperatura(t){
		temperatura -= t
	}
	
	method eliminar(elemento){
		maravillas.remove(elemento)
	}
	method tieneMaravilla(elemento) = maravillas.contains(elemento)
	
}
	