const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const db = require('./db');
const session = require('express-session'); 
const cookieParser = require('cookie-parser');
const nodemailer = require('nodemailer');

const app = express();

app.use(cookieParser());
app.use(session({
    secret: 'tu_secreto_aqui', // Cambia esto por una clave segura
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // Cambia a true si usas HTTPS
}));

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(express.static(path.join(__dirname, 'public')));
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');


// Middleware principal
app.use((req, res, next) => {
    console.log('Middleware funcionando. . .');
    next();
});

// Enrutador de usuarios
const router_usuarios = require('./routes/usuarios');
app.use('/', router_usuarios);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

/*app.get('/encargo', (req, res) => {
  res.send('Página de Encargo');
});*/

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// Configuración del transportador de correo (aquí usaremos Gmail, puedes cambiarlo)
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'tuemail@gmail.com', // Cambia esto por tu correo
      pass: 'tucontraseña'        // Cambia esto por tu contraseña
    }
  });

  app.get('/produc', function(solicitud, resouesta){
    produc.find(function(error, documento){
      if(error){
        console.log("error");
      }
      res.render('catalogo/produc')
    })
  })
  
  // Ruta principal que sirve el formulario
  app.get('/encargo', (req, res) => {
    res.render(path.join(__dirname, 'views', 'encargo.ejs'));
  });

  app.get('/perfil', (req, res) => {
    const data = getData();
    res.render('perfil', { data });
  });
  
  // Ruta para procesar el formulario
  app.post('/enviar-solicitud', (req, res) => {
    const { nombre, email, descripcion, prioridad } = req.body;
  
    // Configuración del correo
    const mailOptions = {
      from: 'tuemail@gmail.com',
      to: 'programador1@example.com, programador2@example.com', // Aquí puedes poner los correos de los programadores
      subject: 'Nueva Solicitud de Encargo de Software',
      text: `Se ha recibido una nueva solicitud de encargo:
      
      Nombre: ${nombre}
      Email: ${email}
      Descripción: ${descripcion}
      Prioridad: ${prioridad}
      `
    };
  
    // Enviar el correo
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log(error);
        res.status(500).send('Hubo un error al enviar el correo');
      } else {
        console.log('Correo enviado: ' + info.response);
        res.send('Solicitud enviada con éxito.');
      }
    });
  });

  app.get('/recuperarCliente', (req, res) => {
    res.render(path.join(__dirname, 'views', 'recuperarCliente.ejs'));
  });

  app.get('/producto/:id', (req, res) => {
    const id = req.params.id;
    const producto = productos[id];

    if (producto) {
        res.render('producto', { producto });
    } else {
        res.status(404).send('Producto no encontrado');
    }
});
