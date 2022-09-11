select a.id_coche , b.nombre_modelo, c.nombre_marca , d.nombre_grupo , a.fecha_compra , a.matricula , e.nombre_color , f.kms_ultimo_recuento, h.nombre_aseguradora , g.num_poliza  
from jesus_romero.coches a inner join jesus_romero.modelo b on a.id_modelo  = b.id_modelo
	  					   inner join jesus_romero.marca c on b.id_marca = c.id_marca 
	  					   inner join jesus_romero.grupo_empresarial d on c.id_grupo = d.id_grupo
	  					   inner join jesus_romero.color e on a.id_color = e.id_color
	  					   left join (select  id_coche, max(kilometros) as kms_ultimo_recuento from jesus_romero.historial_kms group by id_coche) as f  on a.id_coche = f.id_coche
	  					   left join jesus_romero.coches_polizas g  on a.id_coche = g.id_coche and g.vigente = '1'
	  					   left join jesus_romero.aseguradora h on g.id_aseguradora = h.id_aseguradora ;
	  					   

	  					  
	  					  
	  					  

