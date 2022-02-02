/** 
 * Apellido y nombre: Aylen Chalco	
 * Legajo: 1666780
 */

 
 class Empresa{
 	const descargas = []
 	
    method elMasRanqueado(fecha) = descargas.map({descarga => descarga.vecesDescargado(fecha)}).max()	
 }
 
 class Descarga{
 	var derechoDeAutor 
 	const property fechas = [] 
 	const property usuarios = [] 
  	
 /* 	method precio(cliente) = self.precioSinRecarga(cliente) + self.recargo(cliente) 
 	
 	method recargo(cliente) = self.precioSinRecarga(cliente) * cliente.recargoPorPlan()*/
 	
 	method precio(cliente) = self.precioSinRecarga(cliente) * cliente.recargoPorPlan()
 	
 	method precioSinRecarga(cliente) = derechoDeAutor.monto() + cliente.montoPorCompania(derechoDeAutor) + self.comercializacionDeContenidosParaCelulares() 
 	
 	method  comercializacionDeContenidosParaCelulares() = derechoDeAutor.monto() * 0.25
 	
 	 method registrarFecha(fecha){
 	 	
 	 	fechas.add(fecha)
 	 }
 	 
 	method esDelUltimoMes(cliente){
 		fechas.any({fecha => (new Date()).year() == fecha.year() && (new Date()).month() == fecha.month() })
 	}
 	
 	
 	
 	
 	
 	method registrarUsuario(cliente){
 		usuarios.add(cliente)
 	}
 	
 	method seDescargoMasDeUnaVez(cliente) = usuarios.filter({usuario => usuario == cliente}).size() > 2
 	
 	method vecesDescargado(fecha) =  fechas.filter({unafecha => unafecha == fecha}).sum()
 }
 
 class DerechoDeAutor{
 	
 	method monto()
 }
 
 class Ringtone inherits DerechoDeAutor {
 	var minutos
 	var precioPorMinuto
 	
 	override method monto() = minutos * precioPorMinuto
 }
 
  class Chiste inherits DerechoDeAutor {
  	
  	var montoFijo
  	var texto
  	
 	override method monto() = montoFijo * texto.size()
 }
 
  class Juego inherits DerechoDeAutor {
  	var montoJuego
  	
 	override method monto() = montoJuego
 }
 
 class Cliente{
 	
 	var property tipoCompania
 	var tipoPlan
 	var saldo
 	var gastoPorMes = 0
 	const descargas = []
 	
 	method cambiarTipoPlan(nuevoPlan) {
 		tipoPlan = nuevoPlan
 	}
 	
 	method montoPorCompania(derechoDeAutor) = tipoCompania.monto(derechoDeAutor)
 
 	method recargoPorPlan() = tipoPlan.recarga()
 	
 	method esColgado() = descargas.any({descarga=>descarga.seDescargoMasDeUnaVez(self)})
 	
 	
 	method descargar(descarga){
 		
 		tipoPlan.descargarPorPlan(self,descarga)
 		
 		}
 	method puedePagar(descarga) = saldo > descarga.precio(self)
 	
 	method pagar(descarga){
 		saldo = saldo - descarga.precio(self)
 	}
 	
 	method registrarDescarga(descarga){
 		
 		descarga.registrarFecha(new Date())
 		descarga.registrarUsuario(self)
 		descargas.add(descarga)
 	}
 	
 	method acumularGasto(descarga){
 		gastoPorMes = gastoPorMes + descarga.precio(self)
 	}
 	
 	method gastoDelMes() = self.descargasUltimoMes().map({descarga => descarga.precio(self)}).sum()
 
 	method descargasUltimoMes() = descargas.filter({descarga => descarga.esDelUltimoMes(self)})
 	
 }
 
 
 
 object prepago {
 	
 	method descargarPorPlan(cliente,descarga) {
 		if (cliente.puedePagar(descarga)){
 			cliente.pagar(descarga)
 			cliente.registrarDescarga(descarga)
 		}
 		else {}
 	}
 	
 	method recarga() = 1.1
 }
 
 object facturado {
 	 method descargarPorPlan(cliente,descarga){
 	 		cliente.registrarDescarga(descarga)
 	 		cliente.acumularGasto(descarga)
 	 	}
 	
 	method recarga() = 1
 }
 
 class Compania{
 	
 	method monto(derechoDeAutor) = derechoDeAutor.monto() * 0.05
 }
 
 class Nacional inherits Compania { }
 
 class Extranjera inherits Compania {
 	var impuesto
 	
 	override method monto(derechoDeAutor) = super(derechoDeAutor) + impuesto
 	
 	method cambiarImpuesto(nuevoImpuesto) { impuesto = nuevoImpuesto }
 }
 
 
 
 
 
 
 
 