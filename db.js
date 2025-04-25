const mysql = require('mysql');
const bcrypy = require('bcrypt');

const contraseña = 'ContraseñaSegura'; //La contraseña que se desea encriptar
const saltRounds = 10; //numero de rondas

const conexion = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    port: 3306,
    database: 'cloudup'
});

conexion.connect((err) => {
    if (err) {
        console.error('Error conectando a la base de datos:', err);
        return;
    }
    console.log('Conexión a la base de datos establecida');
});

//Encriptar 
bcrypy.hash(contraseña, saltRounds, (err, hash) =>{
    if (err) {
        console.error('Encriptar errada:', err);
        return;
    }
    console.log('Contraseña encriptada', hash);
});

const hashedPassword = '$2b$10$EIXZ1Q1Z1Z1Z1Z1Z1Z1Z1Oe1Z1Z1Z1Z1Z1Z1Z1Z1Z1Z1Z1Z1Z1'; // Reemplaza esto con tu hash
const passwordToCheck = 'miContraseñaSegura'; // La contraseña que deseas verificar

//Compara contraseña
bcrypy.compare(passwordToCheck, hashedPassword, (err, result) => {
    if (err){
        console.err('Comparacion erradda', err);
        return;
    }
    if (result){
        console.log('Contraseña correcta!');
    }
    else{
        console.log('Contraseña incorrecta');
    }
});

module.exports = conexion;
