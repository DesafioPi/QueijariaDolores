var database = require("../database/config");

function buscarUltimasMedidas(idSala, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM leitura JOIN sensor
						ON leitura.fk_sensor = sensor.id
                    WHERE fk_sala = ${idSala}
                    ORDER BY momento desc LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idSala) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                        FROM leitura JOIN sensor
						ON leitura.fk_sensor = sensor.id
                    WHERE fk_sala = ${idSala}
                    ORDER BY momento desc LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarTempUmidHora() {

    var instrucaoSql = `SELECT ROUND(AVG(dht11_umidade), 2), ROUND(AVG(dht11_temperatura), 2), DATE_FORMAT(momento, "%H:00") as hora FROM leitura group by hora;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarTempUmidHora
}
