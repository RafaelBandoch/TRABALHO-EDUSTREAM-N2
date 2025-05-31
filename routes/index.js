var express = require('express');
var router = express.Router();
const db = require('../banco'); // ajuste o caminho

// Função para definir usuário global
function setGlobalUsuario(usuario) {
  if (usuario && usuario.usucodigo && usuario.usuemail) {
    global.usuarioCodigo = usuario.usucodigo;
    global.usuarioEmail = usuario.usuemail;
  } else {
    global.usuarioCodigo = null;
    global.usuarioEmail = null;
  }
}

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

// GET Menu
router.get('/menu', async (req, res) => {
  try {
    const [cursos] = await db.query('SELECT * FROM cursos');

    res.render('menu', {
      usuarioCodigo: global.usuarioCodigo,
      usuarioEmail: global.usuarioEmail,
      title: 'Menu - EduStream',
      cursos: cursos 
    });

  } catch (err) {
    console.error('Erro ao carregar cursos:', err);
    res.status(500).send('Erro ao carregar cursos.');
  }
});


// GET cadastro
router.get('/cadastro', (req, res) => {
  res.render('cadastro', {
    mensagem: undefined,
    sucesso: false
  });
});

router.get("/curso/:id", async function (req, res) {
  const id = req.params.id;
  const curso = await global.banco.buscaCursoId(id);
  const aulas = await global.banco.buscaAulaCursoId(id);
  console.log(curso);
  console.log(aulas);
  console.log('[DEBUG - TIPO DE AULAS]', typeof aulas); // deve ser 'object'
  console.log('[DEBUG - É ARRAY?]', Array.isArray(aulas)); // deve ser true
  console.log('[DEBUG - AULAS]', aulas); // veja a estrutura
  res.render('cursos', { curso, aulas });
});
 
// GET Meus Cursos
router.get('/meus_cursos', async function (req, res) {
  verificarLogin(res);
  const usuario = String(global.usuarioCodigo);
  console.log(usuario);
  const cursos = await global.banco.buscaCursoUsuario(usuario);
  console.log(cursos);
  res.render('meus_cursos', { cursos });
});

//GET Aulas
router.get('/aula/:id', async function (req, res) {
  verificarLogin(res);
  const usuario = String(global.usuarioCodigo);
  const id = req.params.id;
  console.log('Id do usuario: ', usuario);
  console.log('Id da aula: ', id);
  const aula = await global.banco.buscaAulaId(id);
  const curso = await global.banco.buscaCursoAulaId(aula.curcodigo);
  const aulas = await global.banco.buscaAulaCursoId(aula.curcodigo);
  console.log('Lista de aulas: ', aulas);
  console.log('Infos da aula: ', aula);
  console.log('Curso da aula: ', curso);
  res.render('aula', { aula, curso, aulas });
});
// GET Aulas Salvas
router.get('/aulas_salvas/:usucodigo', async (req, res) => {
  verificarLogin(res);
  if (!global.usuarioEmail || global.usuarioEmail == "") return;

  const usucodigo = req.params.usucodigo;

  if (usucodigo !== String(global.usuarioCodigo)) {
    return res.status(403).send('Acesso negado. Você só pode ver suas próprias aulas salvas.');
  }

  try {
    const [aulas] = await db.query(`
      SELECT 
        a.aulaid,
        a.titulo,
        COALESCE(p.status, 'nao iniciado') AS status
      FROM aula a
      JOIN progresso p ON a.aulaid = p.id_aula
      WHERE p.id_usuario = ?
      ORDER BY a.aulaid;
    `, [usucodigo]);

    res.render('aulas_salvas', { aulas, usuarioCodigo: usucodigo });

  } catch (error) {
    console.error('Erro ao carregar aulas salvas:', error);
    res.status(500).send('Erro ao carregar aulas salvas.');
  }
});



// POST Cadastro 
router.post('/cadastro', async function(req, res, next){
  const email = req.body.email;
  const senha = req.body.senha;

  if (!email || !senha) {
    return res.render('cadastro', {
      mensagem: "Todos os campos devem ser preenchidos",
      sucesso: false
    });
  }
  
  await global.banco.CadastroUsuario(email, senha);
  return res.render('cadastro', {
    mensagem: "Usuário cadastrado com sucesso.",
    sucesso: true
  });
});

// POST Login
router.post('/login', async function(req, res, next){
  const email = req.body.email ;
  const senha = req.body.senha;

  const usuario = await global.banco.buscarUsuario({email,senha});

  if (usuario && usuario.usucodigo) {
    setGlobalUsuario(usuario);
    res.redirect('/menu');  
  } else {
    res.redirect('/');
  }
});

/**
 * Funções diversas
 */
function verificarLogin(res)
{
  if (!global.usuarioEmail || global.usuarioEmail == "")
    res.redirect('/');
}

module.exports = router;
