const express = require('express');
const router = express.Router();
const conexion = require('../db'); // Asegúrate de que tienes el archivo db.js configurado correctamente
const { status } = require('express/lib/response');
const { query } = require('express');
const bcrypt = require('bcrypt');
const bodyParser = require('body-parser');
const nodemailer = require('nodemailer');
const path = require('path');

router.get('/', (req, res) => {
    res.render('index.ejs');
});

const emailC = (correo) => {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return regex.test(correo);
};

// Función para validar la contraseña
const passwordC = (contraseña) => {
    return contraseña.length >= 6; // Por ejemplo, longitud mínima de 6 caracteres
};

// Función para validar que solo contenga letras
const nombreApellidoC = (texto) => {
    const regex = /^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$/; // Permite letras y espacios
    return regex.test(texto);
};

router.get('/register', (req, res) => {
    res.render('register.ejs');
});

router.post('/register', async (req, res) => {
    const { nombre, apellido, correo, contraseña } = req.body;

    // Validar que todos los campos estén llenos
    if (!nombre || !apellido || !correo || !contraseña) {
        return res.status(400).send('Todos los campos son requeridos');
    }

    // Validar el formato del correo electrónico
    if (!emailC(correo)) {
        return res.status(400).send('El correo electrónico no es válido');
    }

    // Validar la contraseña
    if (!passwordC(contraseña)) {
        return res.status(400).send('La contraseña debe tener al menos 6 caracteres');
    }

     try {
        const hashedPassword = await bcrypt.hash(contraseña, 10); // Encriptar la contraseña con bcrypt

        // Validar que el nombre y apellido solo contengan letras
        if (!nombreApellidoC(nombre)) {
            return res.status(400).send('El nombre solo debe contener letras');
        }

        if (!nombreApellidoC(apellido)) {
            return res.status(400).send('El apellido solo debe contener letras');
        }
    

    // Si todas las validaciones pasan, proceder a insertar en la base de datos
    conexion.query(
        'INSERT INTO cliente (nombre, apellido, correo, contraseña) VALUES (?, ?, ?, ?)',
        [nombre, apellido, correo, hashedPassword],
        (err, result) => {
            if (err) {
                console.error('Error al registrar cliente:', err);
                return res.status(500).send('Error al registrar cliente');
            }
            console.log('Cliente registrado correctamente');
            res.redirect('/login');
        }
    );
} catch (error) {
    console.error('Error al encriptar la contraseña:', error);
    return res.status(500).send('Error al registrar cliente');
}
});

router.get('/login', (req, res) => {
    res.render('login.ejs')
});

router.post('/login', (req, res) => {
    const { correo, contraseña } = req.body;

    if (!correo || !contraseña) {
        return res.status(400).send('Nombre de usuario y contraseña son requeridos');
    }

    conexion.query('SELECT * FROM cliente WHERE correo = ?', [correo], async (err, results) => {
        if (err) {
            console.error('Error al buscar cliente:', err);
            return res.status(500).send('Error interno');
        }

        if (results.length === 0) {
            return res.status(401).send('Usuario no encontrado');
        }

        const cliente = results[0];
        const match = await bcrypt.compare(contraseña, cliente.contraseña);

        if (match) {
            req.session.user = cliente;
            res.redirect('/catalogo');
        } else {
            res.status(401).send('Contraseña incorrecta');
        }
    });
});

router.get('/catalogo', (req, res)=>{
    res.render('catalogo.ejs');
});

const emailP = (correo) => {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    return regex.test(correo);
}

const passwordP = (contraseña) => {
    return contraseña.length >= 6;
}

const nombreApellidoP = (texto) => {
    const regex = /^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$/;
    return regex.test(texto);
}

//validacion nombre usuario
const nombreUsuarioP = (usuario) => {
    const regex = /^[A-Za-z0-9]{5,}$/;
    return regex.test(usuario);
}

const telefonoP = (texto) => {
    const regex = /^\d+$/;
    return regex.test(texto);
}

router.get('/registerProgramin', (req, res) => {
    res.render('registerProgramin.ejs');
});

// routes.js (parte del código relevante)

router.post('/registerProgramin', async (req, res) => {
    const { nombre, apellido, correo, nombre_usuario, contraseña, telefono } = req.body

    if(!nombre || !apellido || !correo || !nombre_usuario || !contraseña || !telefono) {
        return res.status(400).send('Todos los campos son requeridos');
    }

    if(!nombreApellidoP(nombre)) {
        return res.status(400).send('El nombre solo debe de tener letras');
    }

    if(!nombreApellidoP(apellido)) {
        return res.status(400).send('El apellido solo debe de tener letras');
    }
    if(!emailP(correo)) {
        return res.status(400).send('El correo electronico es invalido');
    }

    if(!nombreUsuarioP(nombre_usuario)) {
        return res.status(400).send('El noombre de usuario solo puede tener letras y numeros y almenos 5 caracteres');
    }

    if(!passwordP(contraseña)) {
        return res.status(400).send('La contraseña debe de tener como minimo 6 caracteres');
    }

    if(!telefonoP(telefono)) {
        return res.status(400).send('El telefono solo debe de tener numeros');
    }

    try {
        const hashedPassword = await bcrypt.hash(contraseña, 10); // Encriptar la contraseña con bcrypt

        // Validar que el nombre y apellido solo contengan letras
        if (!nombreApellidoP(nombre)) {
            return res.status(400).send('El nombre solo debe contener letras');
        }

        if (!nombreApellidoP(apellido)) {
            return res.status(400).send('El apellido solo debe contener letras');
        }
    
    // Si todas las validaciones pasan, proceder a insertar en la base de datos
    conexion.query(
        'INSERT INTO programador (nombre, apellido, correo, nombre_usuario, contraseña, telefono) VALUES (?, ?, ?, ?, ?, ?)',
        [nombre, apellido, correo, nombre_usuario, hashedPassword, telefono],
        (err, result) => {
            if (err) {
                console.error('Error al registrar programador:', err);
                return res.status(500).send('Error al registrar programador');
            }
            console.log('Programador registrado correctamente');
            res.redirect('/loginProgramin');
        }
    );
} catch (error) {
    console.error('Error al encriptar la contraseña:', error);
    return res.status(500).send('Error al registrar programador');
}
});

router.get('/loginProgramin', (req, res) => {
    res.render('loginProgramin.ejs')
});

router.post('/loginProgramin', (req, res) => {
    const { nombre_usuario, contraseña } = req.body;

    if (!nombre_usuario || !contraseña) {
        return res.status(400).send('Nombre de usuario y contraseña son requeridos');
    }

    conexion.query('SELECT * FROM programador WHERE nombre_usuario = ?', [nombre_usuario], async (err, results) => {
        if (err) {
            console.error('Error al buscar programador:', err);
            return res.status(500).send('Error interno');
        }

        if (results.length === 0) {
            return res.status(401).send('Usuario no encontrado');
        }

        const programador = results[0];
        const match = await bcrypt.compare(contraseña, programador.contraseña);

        if (match) {
            req.session.user = programador.id_programador;
            res.redirect('/catalogoProgramin');
        } else {
            res.status(401).send('Contraseña incorrecta');
        }
    });
});



router.get('/catalogoProgramin', (req, res) => {
    res.render('catalogoProgramin.ejs');
});

router.get('/logout', (req, res) => {
    if (req.session && req.session.user) {
        const { id, rol } = req.session.user;

        // Definir las consultas por tipo de usuario
        let insertQuery = '';
        let updateQuery = '';
        let insertParams = [id];
        let updateParams = [id];

        switch (rol) {
            case 'programador':
                insertQuery = 'INSERT INTO sesion_programador (id_programador, estado) VALUES (?, "cierre_sesion")';
                updateQuery = 'UPDATE programador SET activo = 0 WHERE id_programador = ?';
                break;
            case 'cliente':
                insertQuery = 'INSERT INTO sesion_cliente (id_cliente, estado) VALUES (?, "cierre_sesion")';
                updateQuery = 'UPDATE cliente SET activo = 0 WHERE id_cliente = ?';
                break;
            case 'admin':
                insertQuery = 'INSERT INTO sesion_admin (id_admin, estado) VALUES (?, "cierre_sesion")';
                updateQuery = 'UPDATE admin SET activo = 0 WHERE id_admin = ?';
                break;
            default:
                return res.status(400).send('Tipo de usuario no reconocido');
        }

        // Registrar el cierre de sesión
        conexion.query(insertQuery, insertParams, (err, result) => {
            if (err) {
                console.error('Error al registrar cierre de sesión:', err);
                return res.status(500).send('Error al cerrar sesión');
            }

            // Actualizar estado a inactivo
            conexion.query(updateQuery, updateParams, (err, updateResult) => {
                if (err) {
                    console.error('Error al actualizar estado del usuario:', err);
                    return res.status(500).send('Error al cerrar sesión');
                }

                // Destruir la sesión
                req.session.destroy((err) => {
                    if (err) {
                        console.error('Error al destruir sesión:', err);
                        return res.status(500).send('Error al cerrar sesión');
                    }
                    res.redirect('/index'); // o donde quieras redirigir
                });
            });
        });
    } else {
        res.redirect('/');
    }
});

router.get('/catalogoAdmin', (req, res)=>{
    res.render('catalogoAdmin.ejs');
});

router.get('/listado-clientes', (req, res) => {
    conexion.query('SELECT * FROM cliente', (err, clientes) => {
        if (err) {
            console.error('Error al obtener clientes:', err);
            return res.status(500).send('Error al obtener clientes');
        }
        res.render('listadoClientes.ejs', { cliente: clientes }); // Asegúrate de usar { cliente: clientes }
    });
});

router.get('/listado-programadores', (req, res) => {
    conexion.query('SELECT * FROM programador', (err, result) => {
        if (err) {
            console.error('Error al obtener programadores:', err);
            return res.status(500).send('Error al obtener programadores');
        }
        res.render('listadoProgramadores.ejs', { programadores: result });
    });
});


// Mostrar formulario de edición de programador
router.get('/editar/:id', (req, res) => {
    const idProgramador = req.params.id;

    conexion.query(
        'SELECT * FROM programador WHERE id_programador = ?',
        [idProgramador],
        (err, result) => {
            if (err) {
                console.error('Error al obtener programador:', err);
                return res.status(500).send('Error al obtener programador');
            }

            if (result.length === 0) {
                return res.status(404).send('Programador no encontrado');
            }

            res.render('editarProgramador.ejs', { programador: result[0] });
        }
    );
});

// Procesar la edición de un programador
router.post('/programadores/editar/:id', (req, res) => {
    const idProgramador = req.params.id;
    const { nombre, apellido, correo, nombre_usuario, contraseña, telefono } = req.body;

    if (!nombre || !apellido || !correo || !nombre_usuario || !contraseña || !telefono) {
        return res.status(400).send('Todos los campos son requeridos');
    }

    conexion.query(
        'UPDATE programador SET nombre = ?, apellido = ?, correo = ?, nombre_usuario = ?, contraseña = ?, telefono = ? WHERE id_programador = ?',
        [nombre, apellido, correo, nombre_usuario, contraseña, telefono, idProgramador],
        (err, result) => {
            if (err) {
                console.error('Error al editar programador:', err);
                return res.status(500).send('Error al editar programador');
            }
            console.log('Programador editado correctamente');
            res.redirect('/listado-programadores');
        }
    );
});

// Eliminar un programador
router.post('/eliminar-programador/:id', (req, res) => {
    const idProgramador = req.params.id;

    conexion.query(
        'DELETE FROM programador WHERE id_programador = ?',
        [idProgramador],
        (err, result) => {
            if (err) {
                console.error('Error al eliminar programador:', err);
                return res.status(500).send('Error al eliminar programador');
            }
            console.log('Programador eliminado correctamente');
            res.redirect('/listado-programadores');
        }
    );
});

router.get('/editarCliente/:id', (req, res) => {
    const idCliente = req.params.id;

    conexion.query(
        'SELECT * FROM cliente WHERE id_cliente = ?',
        [idCliente],
        (err, result) => {
            if (err) {
                console.error('Error al obtener cliente:', err);
                return res.status(500).send('Error al obtener cliente');
            }

            if (result.length === 0) {
                return res.status(404).send('Cliente no encontrado');
            }

            res.render('editarCliente', { cliente: result[0] });
        }
    );
});


router.post('/clientes/editar/:id', (req, res) => {
    const idCliente = req.params.id;
    const { nombre, apellido, correo, contraseña } = req.body;

    if (!nombre || !apellido || !correo || !contraseña) {
        return res.status(400).send('Todos los campos son requeridos');
    }

    conexion.query(
        'UPDATE cliente SET nombre = ?, apellido = ?, correo = ?, contraseña = ? WHERE id_cliente = ?',
        [nombre, apellido, correo, contraseña, idCliente],
        (err, result) => {
            if (err) {
                console.error('Error al editar cliente:', err);
                return res.status(500).send('Error al editar cliente');
            }
            console.log('Cliente editado correctamente');
            res.redirect('/listado-clientes'); // Asegúrate de que la redirección sea correcta
        }
    );
});

// Eliminar un cliente
router.post('/eliminar-cliente/:id', (req, res) => {
    const idCliente = req.params.id;

    conexion.query(
        'DELETE FROM cliente WHERE id_cliente = ?',
        [idCliente],
        (err, result) => {
            if (err) {
                console.error('Error al eliminar cliente:', err);
                return res.status(500).send('Error al eliminar cliente');
            }
            console.log('Cliente eliminado correctamente');
            res.redirect('/listado-clientes');
        }
    );
});

router.get('/loginAdmin', (req, res)=>{
    res.render('loginAdmin.ejs');
})
router.post('/loginAdmin', (req, res) => {
    const { correo, contraseña, clave_especial } = req.body;

    // Validar que todos los campos requeridos estén presentes
    if (!correo || !contraseña || !clave_especial) {
        return res.status(400).send('Todos los campos son requeridos');
    }

    // Consulta SQL para verificar las credenciales del administrador
    const sql = 'SELECT * FROM administrador WHERE correo = ? AND contraseña = ? AND clave_especial = ?';
    const values = [correo, contraseña, clave_especial];

    // Ejecutar la consulta
    conexion.query(sql, values, (err, result) => {
        if (err) {
            console.error('Error al autenticar administrador:', err);
            return res.status(500).send('Error interno del servidor');
        }

        // Verificar si se encontró un administrador con las credenciales proporcionadas
        if (result.length === 0) {
            return res.status(401).send('Correo electrónico, contraseña o clave especial incorrectos');
        }

        // Si las credenciales son correctas, guardar el administrador en la sesión
        req.session.admin = result[0]; // Guardar el administrador en la sesión

        // Redirigir al dashboard o a la página que prefieras
        res.redirect('/catalogoAdmin');
    });
});

router.get('/catalogo', (req, res) => {
    res.render('catalogo.ejs');
});

router.post('/catalogo', (req, res) =>{
    res.redirect('/produc')
});

router.get('/perfil', async (req, res) => {
    try {
        const [user] = await conexion.query(`
            SELECT nombre, apellido, correo 
            FROM programador
            WHERE id_programador = ?
        `, [req.session.user.id_programador]);

        if (user.length === 0) {
            return res.status(404).json({
                success: false,
                message: 'Usuario no encontrado'
            });
        }

        res.render({
            success: true,
            user: user[0]
            ('perfil', {user: user[0], success: true})
        });

    } catch (error) {
        console.error('Error al obtener perfil:', error);
        res.status(500).json({
            success: false,
            message: 'Error al obtener datos del usuario'
        });

        }  
    
} );

module.exports = router;