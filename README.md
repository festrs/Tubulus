[![Codacy Badge](https://api.codacy.com/project/badge/Grade/9dfda652476c4a8b92325b21d0bf6549)](https://www.codacy.com/app/festrs/Tubulus?utm_source=github.com&utm_medium=referral&utm_content=festrs/Tubulus&utm_campaign=badger)
#**Tubulus**  [![Build Status](https://travis-ci.org/festrs/Tubulus.svg?branch=master)](https://travis-ci.org/festrs/Tubulus) [![codebeat badge](https://codebeat.co/badges/89fb165f-b746-47ef-b36d-c0b8b455be03)](https://codebeat.co/projects/github-com-festrs-tubulus)


Este é um projeto que visa facilitar a vida de quem paga ou tem que pagar boletos bancários. Você escaneia o boleto com a camera do celular, ele salva em uma lista separada por mês. A partir dai você tem todos os boletos em um só lugar e pode pagar quando quiser sem se preocupar em carregar o boleto com você. 

O Tubulus chegou para ficar na sua vida, e para você não esquecer de pagar aquele boleto e gerar aquela multa indesejada, ele vem com sistema de avisos antes ou no mesmo dia do vencimento.

Você já teve que digitar aquele código de barras do boleto? Agora com Tubulus você consegue copiar ele facilmente. É só escanear e clicar no número.

Ainda conta com o acompanhamento dos gastos por mês, pois ele soma todos os boletos que você escanear.

- [x] Repositório para boletos
- [x] Soma dos valores
- [x] Separados Mensalmente
- [x] Alerta de vencimento
- [x] Facilidade na cópia da "Linha do Boleto" (número do boleto)
- [x] Armazenamento local
- [x] Grátis

# Body (conteúdo)

Este Projeto traz o uso de alguma classes, como CoreDataTableViewController. Esta classe facilita a vida
de quem quer trabalhar com CoreData. Baseada numa classe em ObjectiveC do curso de [iOS CSP193 Stanford](http://www.stanford.edu/class/cs193p/cgi-bin/drupal/)

O arquivo Extensions.swift traz também uma coletanea de extensions, nas quais você poderá utilizar no seu projeto, estas extensions foram criadas por mim e por terceiros. 

Há também a classe BarCodeCalc, na qual faz os calculos a partir do código de barras para a linha digitável do codigo, informações sobre os [calculos](http://boletobancario-codigodebarras.blogspot.com.br/2010/03/desvendando-os-segredos-do-boleto.html)  [modulo10 e 11](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)  

Este projeto visa o crescimento da comunidade de Swift.

# Autor

[Felipe Pereira](http://festrs.github.io/)

**Colaboradores** Jáder Nunes, Vicente Miraber, Gabriel Pereira

## License

**Tubulus** is available under the MIT license. See the LICENSE file for more info.