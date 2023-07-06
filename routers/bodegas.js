import mysql from 'mysql2';
import {Router} from 'express';

const storageBodegas = Router();
let connection = undefined;
storageBodegas.use((req,res,next)=>{
    let myConfig = JSON.parse(process.env.MY_CONNECTED)
    connection = mysql.createPool(myConfig);
    next();
});

storageBodegas.get("/", (req,res)=>{
    connection.query('SELECT nombre FROM bodegas ORDER BY nombre ASC', (error, results)=>{
        if(error){
            res.status(500).json({ error: 'Ocurrio un error en el servidor'});
        } else {
            res.json(results);
        }
        
    });
});

export default storageBodegas;