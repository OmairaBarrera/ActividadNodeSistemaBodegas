import dotenv from 'dotenv';
import express from 'express';
dotenv.config();
const appExpress = express();

appExpress.get('/campus', (req,res)=>{
    res.send("Hola");
})

//Levantar el servidor
const config = JSON.parse(process.env.MY_CONFIG);
appExpress.listen(config, ()=>console.log(`http://${config.hostname}:${config.port}`));