object minionSinArmas inherits Exception{}

class Villano {
	var property minions = []
 	var property ciudad

	method nuevoMinion(){
		const minion = new Minion(bananas = 5)
	 	const rayoCongelante = new Arma(nombre = "Rayo Congelante", poder = 10)
		minion.otorgarArma(rayoCongelante)
		minions.add(minion)
	}
	
	method agregarMinion(minion){
		minions.add(minion)
	}

	method planificar(maldad){
		maldad.asignarMinions(minions.filter{m=>maldad.esApto(m)})
	}
	method realizar(maldad){
		maldad.realizar(ciudad)
	}	
	method minionMasUtil() = minions.max({x=> x.maldades()})
	method minionInutiles() = minions.filter({x=> x.maldades() < 1})
	
}

class Minion {
	var property bananas
	var property color = amarillo
	var property armas = []
	var property maldades = 0
	
	method perderArmas() { armas.clear()}

	method comerBanana(){ 
		bananas -= 1
		bananas = bananas.max(0)
	}
	method alimentar(cant){
		bananas += cant
	}
	method agregarMaldad(){
		maldades += 1
	}
	
	method otorgarArma(arma){
		armas.add(arma)
	}
	method tieneArma(nombre){
		return armas.any{x=>x.nombre() == nombre}
	}
	method esPeligroso(){
		return armas.size() > 2
	}
	method consumirSueroMutante(){
		color.beberSuero(self)
		self.comerBanana()
	}
	method poderArmaMasPoderosa(){
		if (armas.isEmpty())
			throw minionSinArmas 
		return armas.max{a=> a.poder()}.poder()
	}
	method nivelConcentracion(){
		return color.nivelConcentracion(self)
	}
}

object amarillo{
	method nivelConcentracion(minion){
		return minion.bananas() + minion.poderArmaMasPoderosa()
	}
	method beberSuero(minion){
		minion.color(violeta)
		minion.perderArmas()
	}
}

object violeta {
	method nivelConcentracion(minion){
		return minion.bananas()
	}
	method beberSuero(minion){
		minion.color(amarillo)
	}
}

class Arma{
	var property nombre
	var property poder
}

