import mysql from 'mysql2';
import {Router} from 'express';

const storageBodegas = Router();
let connection = undefined;

storageBodegas.use((req,res,next)=>{
    let myConfig = JSON.parse(process.env.MY_CONNECTED)
    connection = mysql.createPool(myConfig);
    next();
});

//Listar las bodegas en orden alfabeticamente
storageBodegas.get("/", (req,res)=>{
    connection.query('SELECT nombre FROM bodegas ORDER BY nombre ASC', (error, results)=>{
        if(error){
            res.status(500).json({ error: 'Ocurrio un error en el servidor'});
        } else {
            res.json(results);
        }
        
    });
});

//Crear una bodega
storageBodegas.post('/', (req, res) => {
    /* 
        Datos de entrada esperados en el cuerpo de la solicitud (en formato JSON):
        {
            "nombre": "Nombre a agregar",
            "id_responsable": agregar un id,
            "estado": agregar un estado
        }
    */
    const {nombre,id_responsable,estado} = req.body;  
    const sql = 'INSERT INTO bodegas (nombre, id_responsable, estado) VALUES (?, ?, ?)';
    const nuevaBodega = [nombre,id_responsable,estado];
    //Guardar la nueva bodega en la base de datos
    connection.query(sql,nuevaBodega, (error, result) => {
        if (error) {
            res.status(500).json({ error: 'Ocurrió un error en el servidor' });
        } else {
            res.status(201).json({ mensaje: 'Bodega creada exitosamente' , data : result });
        }
    });

});
export default storageBodegas;