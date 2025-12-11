var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idSala", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idSala", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
});

router.get("/media-TempUmid-hora/:idSala", function (req, res) {
    medidaController.buscarTempUmidHora(req, res);
})

module.exports = router;