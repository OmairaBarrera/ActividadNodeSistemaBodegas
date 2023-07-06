import dotenv from 'dotenv';
import express from 'express';
import storageBodegas from './routers/bodegas.js'
dotenv.config();
const appExpress = express();

appExpress.use(express.json());
//milleware que redirecciona a el router 
appExpress.use("/bodegas", storageBodegas);

//Levantar el servidor
const config = JSON.parse(process.env.MY_CONFIG);
appExpress.listen(config, ()=>console.log(`http://${config.hostname}:${config.port}`));