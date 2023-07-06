import mysql from 'mysql2';
import {Router} from 'express';

const storageProductos = Router();
let connection = undefined;

storageProductos.use((req,res,next)=>{
    let myConfig = JSON.parse(process.env.MY_CONNECTED)
    connection = mysql.createPool(myConfig);
    next();
});

storageProductos.get("/", (req,res)=>{
    
    connection.query( /* SQL */ `SELECT  b.nombre, p.nombre, SUM(i.cantidad) AS TOTAL
    FROM inventarios i 
    INNER JOIN productos p
    ON i.id_producto = p.id
    INNER JOIN bodegas b
    ON i.id_bodega = b.id
    GROUP BY i.id_bodega, i.id_producto
    ORDER BY Total DESC`, (error,results)=>{
        if(error){
            res.status(500).json({ error: 'Ocurrio un error en el servidor'});
        } else {
            res.json(results);
        }
    });
})

export default storageProductos;