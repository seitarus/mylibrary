//
//  PopulateCoreData.swift
//  Biblioteca
//
//  Created by Alejandro Prieto Beltrán on 22/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import CoreData

class Populator {
  
  class func populate(){
    
    let author1 = Author.mr_createEntity()!
    author1.name = "Joe Dominguez"
    
    let author2 = Author.mr_createEntity()!
    author2.name = "Vicki Robin"
    
    let author3 = Author.mr_createEntity()!
    author3.name = "Dale Carnegie"
    
    let author4 = Author.mr_createEntity()!
    author4.name = "Ángel Faustino Garcia"
    
    let author5 = Author.mr_createEntity()!
    author5.name = "Joe Dispenza"
    
    let author6 = Author.mr_createEntity()!
    author6.name = "Gregorio Hernández Jiménez"
    
    let author7 = Author.mr_createEntity()!
    author7.name = "Robin S. Sharma"
    
    let author8 = Author.mr_createEntity()!
    author8.name = "Pierre-Yves McSween"
    
    let author9 = Author.mr_createEntity()!
    author9.name = "Sergio Fernández"
      
    let author11 = Author.mr_createEntity()!
    author11.name = "Howard Marks"
    
    let author13 = Author.mr_createEntity()!
    author13.name = "Bob Nelson"
    
    let author14 = Author.mr_createEntity()!
    author14.name = "Isaac Asimov"
    
    let author15 = Author.mr_createEntity()!
    author15.name = "George Orwell"
    
    let author16 = Author.mr_createEntity()!
    author16.name = "Yuval N. Harari"
    
    let author17 = Author.mr_createEntity()!
    author17.name = "Steve Allen"
    
    let author18 = Author.mr_createEntity()!
    author18.name = "Juan Gómez-Jurado"
    
    let author19 = Author.mr_createEntity()!
    author19.name = "Arturo Pérez-Reverte"
    
    let author20 = Author.mr_createEntity()!
    author20.name = "Robert T. Kiyosaki"
    
    let author21 = Author.mr_createEntity()!
    author21.name = "Og Mandino"
    
    let author22 = Author.mr_createEntity()!
    author22.name = "Francisco Alcaide Hernández"
    
    let author23 = Author.mr_createEntity()!
    author23.name = "Napoleon Hill"

    let author24 = Author.mr_createEntity()!
    author24.name = "Timothy Ferriss"
    
    let author25 = Author.mr_createEntity()!
    author25.name = "Javier Castillo"

    let author26 = Author.mr_createEntity()!
    author26.name = "Eckhart Tolle"
    
    let author27 = Author.mr_createEntity()!
    author27.name = "T. Harv Eker"
    
    let author28 = Author.mr_createEntity()!
    author28.name = "Miguel Ruiz"
    
    let author29 = Author.mr_createEntity()!
    author29.name = "Joël Dicker"
    
    let author30 = Author.mr_createEntity()!
    author30.name = "Jordi Sierra i Fabra"
    
    let author31 = Author.mr_createEntity()!
    author31.name = "Frederick Forsyth"
    
    let author32 = Author.mr_createEntity()!
    author32.name = "Mary Higgins Clark"
    
    let author33 = Author.mr_createEntity()!
    author33.name = "Alafair Burke"
    
    let author36 = Author.mr_createEntity()!
    author36.name = "Lorenzo Silva"
    
    let author37 = Author.mr_createEntity()!
    author37.name = "Walter Isaacson"
    
    let author38 = Author.mr_createEntity()!
    author38.name = "Carmen Mola"
    
    let author39 = Author.mr_createEntity()!
    author39.name = "Alexander Batthyány"
    
    let author40 = Author.mr_createEntity()!
    author40.name = "Curro Cañete"
    
    let author41 = Author.mr_createEntity()!
    author41.name = "César Pérez Gellida"
    
    
    //--------------------
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    
    
    let book1 = Book.mr_createEntity()!
    book1.title = "La Bolsa o la Vida"
    book1.authors = Set([author1, author2]) as NSSet
    book1.isbn = 9780140267648
    book1.publisher = "Penguin Publishing Group"
    book1.reading_state = "Terminado"
    book1.rate = 4.0
    book1.added_at = Date()
    book1.started_on = Date()
    book1.finished_on = formatter.date(from: "2017/11/30")
        
    let book2 = Book.mr_createEntity()!
    book2.title = "Cómo ganar amigos e influir sobre las personas"
    book2.authors = Set([author3]) as NSSet
    book2.isbn = 9788493664923
    book2.publisher = "Elipse"
    book2.image = "http://images.amazon.com/images/P/8493664928.01Z.jpg"
    book2.reading_state = "Terminado"
    book2.rate = 4.5
    book2.added_at = Date()
    book2.started_on = Date()
    book2.finished_on = formatter.date(from: "2018/12/31")
    
    let book3 = Book.mr_createEntity()!
    book3.title = "Invertir tus ahorros y multiplicar tu sinero"
    book3.authors = Set([author3]) as NSSet
    book3.isbn = 9788432903472
    book3.publisher = "Elipse"
    book3.image = "http://images.amazon.com/images/P/8432903477.01Z.jpg"
    book3.reading_state = "Terminado"
    book3.rate = 2.5
    book3.added_at = Date()
    book3.started_on = Date()
    book3.finished_on = formatter.date(from: "2019/01/15")
    
    let book4 = Book.mr_createEntity()!
    book4.title = "Deja de ser tú"
    book4.authors = Set([author5]) as NSSet
    book4.isbn =  9788479538255
    book4.publisher = "Urano"
    book4.image = "https://covers.openlibrary.org/b/id/7371830-L.jpg"
    book4.reading_state = "Terminado"
    book4.rate = 2.5
    book4.added_at = Date()
    book4.started_on = Date()
    book4.finished_on = formatter.date(from: "2019/01/30")
    
    let book5 = Book.mr_createEntity()!
    book5.title = "Educación Financiera Avanzada Partiendo de Cero"
    book5.authors = Set([author6]) as NSSet
    book5.isbn = 9781495247484
    book5.publisher = "CreateSpace Independent Publishing Platform"
    book5.image = "http://images.amazon.com/images/P/1495247481.01Z.jpg"
    book5.reading_state = "Terminado"
    book5.rate = 2.5
    book5.added_at = Date()
    book5.started_on = Date()
    book5.finished_on = formatter.date(from: "2019/02/15")
    
    let book6 = Book.mr_createEntity()!
    book6.title = "El Club de las 5 de la mañana"
    book6.subtitle = "Controla tus mañanas, impulsa tu vida"
    book6.authors = Set([author7]) as NSSet
    book6.isbn = 9788425356902
    book6.publisher = "Penguin Random House Grupo Editorial España"
    book6.image = "http://images.amazon.com/images/P/8425356903.01Z.jpg"
    book6.reading_state = "Terminado"
    book6.rate = 4.5
    book6.added_at = Date()
    book6.started_on = Date()
    book6.finished_on = formatter.date(from: "2019/02/28")
    
    let book7 = Book.mr_createEntity()!
    book7.title = "Realmente Lo Necesitas?"
    book7.subtitle = "La Pregunta Que Te Dara Libertad Financiera = Do You Really Need It?"
    book7.authors = Set([author8]) as NSSet
    book7.isbn = 9788492921850
    book7.publisher = "Empresa Activa"
    book7.image = "https://m.media-amazon.com/images/I/71gi1nWVCVL._AC_UY218_.jpg"
    book7.reading_state = "Terminado"
    book7.rate = 2.5
    book7.added_at = Date()
    book7.started_on = Date()
    book7.finished_on = formatter.date(from: "2019/03/15")
    
    let book8 = Book.mr_createEntity()!
    book8.title = "Vivir sin Jefe"
    book8.authors = Set([author9]) as NSSet
    book8.isbn = 9788496981522
    book8.publisher = "Empresa Activa"
    book7.image = "https://m.media-amazon.com/images/I/81eh6kvO9sL._AC_UY218_.jpg"
    book8.reading_state = "Terminado"
    book8.rate = 3.0
    book8.added_at = Date()
    book8.started_on = Date()
    book8.finished_on = formatter.date(from: "2019/03/30")
    
    let book9 = Book.mr_createEntity()!
    book9.title = "El líder que no tenía cargo"
    book9.authors = Set([author7]) as NSSet
    book9.isbn = 9788499893945
    book9.publisher = "Random House Mondadori"
    book9.image = "http://images.amazon.com/images/P/8499893945.01Z.jpg"
    book9.reading_state = "Terminado"
    book9.rate = 2.5
    book9.added_at = Date()
    book9.started_on = Date()
    book9.finished_on = formatter.date(from: "2019/06/30")
    
    let book10 = Book.mr_createEntity()!
    book10.title = "Lo más importante para invertir con sentido común"
    book10.authors = Set([author11]) as NSSet
    book10.isbn = 9788415505860
    book10.publisher = "Profit Editorial"
    book10.image = "https://m.media-amazon.com/images/I/71z1ZMShiiL._AC_UY218_.jpg"
    book10.reading_state = "Terminado"
    book10.rate = 2.0
    book10.added_at = Date()
    book10.started_on = Date()
    book10.finished_on = formatter.date(from: "2019/07/15")
    
    let book11 = Book.mr_createEntity()!
    book11.title = "Ser jefe para Dummies"
    book11.authors = Set([author13]) as NSSet
    book11.isbn = 9788432902154
    book11.publisher = "Grupo Planeta Spain"
    book10.image = "https://m.media-amazon.com/images/I/81jzLULtuvL._AC_UY218_.jpg"
    book11.reading_state = "Terminado"
    book11.rate = 1.5
    book11.added_at = Date()
    book11.started_on = Date()
    book11.finished_on = formatter.date(from: "2019/07/30")
    
    let book12 = Book.mr_createEntity()!
    book12.title = "Trilogía de la Fundación"
    book12.authors = Set([author14]) as NSSet
    book12.isbn = 9788499083209
    book12.publisher = "Debolsillo"
    book10.image = "https://m.media-amazon.com/images/I/41lmBpTOuRL._AC_UY218_.jpg"
    book12.reading_state = "Terminado"
    book12.rate = 4.5
    book12.added_at = Date()
    book12.started_on = Date()
    book12.finished_on = formatter.date(from: "2019/08/30")
    
    let book13 = Book.mr_createEntity()!
    book13.title = "1984"
    book13.authors = Set([author15]) as NSSet
    book13.isbn = 9788499890944
    book13.publisher = "Random House Mondadori"
    book10.image = "https://m.media-amazon.com/images/I/81HSpSoddtL._AC_UY218_.jpg"
    book13.reading_state = "Terminado"
    book13.rate = 3.5
    book13.added_at = Date()
    book13.started_on = Date()
    book13.finished_on = formatter.date(from: "2019/09/15")
    
    let book14 = Book.mr_createEntity()!
    book14.title = "Sapiens"
    book14.subtitle = "De animales a dioses/ A Brief History of Humankind"
    book14.authors = Set([author16]) as NSSet
    book14.isbn = 9788499926223
    book14.publisher = "Debate"
    book10.image = "https://m.media-amazon.com/images/I/81sBQfVzziL._AC_UY218_.jpg"
    book14.reading_state = "Terminado"
    book14.rate = 3.5
    book14.added_at = Date()
    book14.started_on = Date()
    book14.finished_on = formatter.date(from: "2019/09/30")
    
    let book15 = Book.mr_createEntity()!
    book15.title = "Técnicas Prohibidas De Persuasión, Manipulación E Influencia Usando Patrones De Lenguaje Y Técnicas De Pnl"
    book15.subtitle = "(2A Edición)"
    book15.authors = Set([author17]) as NSSet
    book15.isbn = 9781719587211
    book15.publisher = "CreateSpace Independent Publishing Platform"
    book10.image = "https://m.media-amazon.com/images/I/71h05twjbRL._AC_UY218_.jpg"
    book15.reading_state = "Terminado"
    book15.rate = 3.0
    book15.added_at = Date()
    book15.started_on = Date()
    book15.finished_on = formatter.date(from: "2019/11/26")
    
    let book16 = Book.mr_createEntity()!
    book16.title = "Reina roja"
    book16.authors = Set([author18]) as NSSet
    book16.isbn = 9788466664417
    book16.publisher = "Ediciones B"
    book10.image = "https://m.media-amazon.com/images/I/71GC9IBeQjL._AC_UY218_.jpg"
    book16.reading_state = "Terminado"
    book16.rate = 5.0
    book16.added_at = Date()
    book16.started_on = Date()
    book16.finished_on = formatter.date(from: "2019/12/03")
    
    let book17 = Book.mr_createEntity()!
    book17.title = "Una Historia De España"
    book17.authors = Set([author19]) as NSSet
    book17.isbn = 9788420438177
    book17.publisher = "Alfaguara"
    book17.image = "http://images.amazon.com/images/P/8420438170.01Z.jpg"
    book17.reading_state = "Terminado"
    book17.rate = 3.0
    book17.added_at = Date()
    book17.started_on = Date()
    book17.finished_on = formatter.date(from: "2019/12/03")
    
    let book18 = Book.mr_createEntity()!
    book18.title = "Padre rico, padre pobre"
    book18.authors = Set([author20]) as NSSet
    book18.isbn = 9788466332125
    book18.publisher = "Debolsillo"
    book18.image = "http://images.amazon.com/images/P/846633212X.01Z.jpg"
    book18.reading_state = "Terminado"
    book18.rate = 2.5
    book18.added_at = Date()
    book18.started_on = Date()
    book18.finished_on = formatter.date(from: "2019/12/16")
    
    let book19 = Book.mr_createEntity()!
    book19.title = "El vendedor más grande del mundo"
    book19.authors = Set([author21]) as NSSet
    book19.isbn = 9788499083278
    book19.publisher = "Debolsillo"
    book10.image = "https://m.media-amazon.com/images/I/41LPoQCwQCL._AC_UY218_.jpg"
    book19.reading_state = "Terminado"
    book19.rate = 3.5
    book19.added_at = Date()
    book19.started_on = Date()
    book19.finished_on = formatter.date(from: "2019/12/18")
    
    let book20 = Book.mr_createEntity()!
    book20.title = "Aprendiendo de los mejores"
    book20.authors = Set([author22]) as NSSet
    book20.isbn = 9788416253876
    book20.publisher = "Alienta"
    book20.image = "http://images.amazon.com/images/P/8416253870.01Z.jpg"
    book20.reading_state = "Terminado"
    book20.rate = 1.5
    book20.added_at = Date()
    book20.started_on = formatter.date(from: "2019/12/09")
    book20.finished_on = formatter.date(from: "2019/12/25")
    
    let book21 = Book.mr_createEntity()!
    book21.title = "Piense y hágase rico"
    book21.authors = Set([author23]) as NSSet
    book21.isbn = 9788497778213
    book21.publisher = "Ediciones Obelisco S.l."
    book10.image = "https://m.media-amazon.com/images/I/81wX0gJlorL._AC_UY218_.jpg"
    book21.reading_state = "Terminado"
    book21.rate = 2.0
    book21.added_at = Date()
    book21.started_on = formatter.date(from: "2019/12/29")
    book21.finished_on = formatter.date(from: "2020/01/13")
    
    let book22 = Book.mr_createEntity()!
    book22.title = "Retírate joven y rico"
    book22.authors = Set([author20]) as NSSet
    book22.isbn = 9788466332071
    book22.publisher = "Debolsillo"
    book22.image = "http://images.amazon.com/images/P/8466332073.01Z.jpg"
    book22.reading_state = "Terminado"
    book22.rate = 2.0
    book22.added_at = Date()
    book22.started_on = formatter.date(from: "2020/01/06")
    book22.finished_on = formatter.date(from: "2020/01/20")
    
    let book23 = Book.mr_createEntity()!
    book23.title = "La Semana laboral de 4 horas"
    book23.authors = Set([author24]) as NSSet
    book23.isbn = 9788490567470
    book23.publisher = "RBA Libros"
    book23.image = "http://images.amazon.com/images/P/8490567476.01Z.jpg"
    book23.reading_state = "Terminado"
    book23.rate = 1.5
    book23.added_at = Date()
    book23.started_on = Date()
    book23.finished_on = formatter.date(from: "2020/01/30")
    
    let book24 = Book.mr_createEntity()!
    book24.title = "Loba negra"
    book24.authors = Set([author18]) as NSSet
    book24.isbn = 9788466666497
    book24.publisher = "Ediciones B"
    book10.image = "https://m.media-amazon.com/images/I/81K62Fg+E3L._AC_UY218_.jpg"
    book24.reading_state = "Terminado"
    book24.rate = 5.0
    book24.added_at = Date()
    book24.started_on = Date()
    book24.finished_on = formatter.date(from: "2020/03/15")
    
    let book25 = Book.mr_createEntity()!
    book25.title = "El día que se perdió el amor"
    book25.authors = Set([author25]) as NSSet
    book25.isbn = 9788466347396
    book25.publisher = "Debolsillo"
    book10.image = "https://m.media-amazon.com/images/I/A1tHTnqbf+L._AC_UY218_.jpg"
    book25.reading_state = "Terminado"
    book25.rate = 3.5
    book25.added_at = Date()
    book25.started_on = Date()
    book25.finished_on = formatter.date(from: "2020/05/15")
    
    let book26 = Book.mr_createEntity()!
    book26.title = "El día que se perdió la cordura"
    book26.authors = Set([author25]) as NSSet
    book26.isbn = 9788466346122
    book26.publisher = "Penguin Random House Grupo Editorial España"
    book26.image = "http://images.amazon.com/images/P/8466346120.01Z.jpg"
    book26.reading_state = "Terminado"
    book26.rate = 3.5
    book26.added_at = Date()
    book26.started_on = Date()
    book26.finished_on = formatter.date(from: "2020/05/30")
    
    let book27 = Book.mr_createEntity()!
    book27.title = "Un nuevo mundo, ahora"
    book27.authors = Set([author26]) as NSSet
    book27.isbn = 9788483464113
    book27.publisher = "Debolsillo"
    book10.image = "https://m.media-amazon.com/images/I/61-nId-6HGL._AC_UY218_.jpg"
    book27.reading_state = "Terminado"
    book27.rate = 3.0
    book27.added_at = Date()
    book27.started_on = formatter.date(from: "2020/06/04")
    book27.finished_on = formatter.date(from: "2020/06/15")
    
    let book28 = Book.mr_createEntity()!
    book28.title = "Los Secretos de la Mente Millonaria"
    book28.subtitle = "Como Dominar el Juego Interior de A Riqueza"
    book28.authors = Set([author27]) as NSSet
    book28.isbn = 9788478086085
    book28.publisher = "Editorial Sirio"
    book10.image = "https://m.media-amazon.com/images/I/71WDmR4x0zL._AC_UY218_.jpg"
    book28.reading_state = "Terminado"
    book28.rate = 3.0
    book28.added_at = Date()
    book28.started_on = formatter.date(from: "2020/06/15")
    book28.finished_on = formatter.date(from: "2020/06/20")
    
    let book29 = Book.mr_createEntity()!
    book29.title = "Los cuatro acuerdos"
    book29.subtitle = "Un libro de sabiduría tolteca"
    book29.authors = Set([author28]) as NSSet
    book29.isbn = 9788479532536
    book29.publisher = "Urano"
    book10.image = "https://m.media-amazon.com/images/I/71mVri6PDWL._AC_UY218_.jpg"
    book29.reading_state = "Terminado"
    book29.rate = 3.0
    book29.added_at = Date()
    book29.started_on = formatter.date(from: "2020/06/22")
    book29.finished_on = formatter.date(from: "2020/06/25")
    
    let book30 = Book.mr_createEntity()!
    book30.title = "La verdad sobre el caso Harry Quebert"
    book30.authors = Set([author29]) as NSSet
    book30.isbn = 9788466332286
    book30.publisher = ""
    book30.image = "http://images.amazon.com/images/P/8466332286.01Z.jpg"
    book30.reading_state = "Terminado"
    book30.rate = 3.0
    book30.added_at = Date()
    book30.started_on = formatter.date(from: "2020/06/27")
    book30.finished_on = formatter.date(from: "2020/07/11")
    
    let book31 = Book.mr_createEntity()!
    book31.title = "Cuatro días de enero"
    book31.subtitle = "(Inspector Mascarell #Volumen 1)"
    book31.authors = Set([author30]) as NSSet
    book31.isbn = 9788483469019
    book31.publisher = "Debolsillo"
    book31.image = "http://image.casadellibro.com/libros/0/cuatro-dias-de-enero-9788483469019.jpg"
    book31.reading_state = "Terminado"
    book31.rate = 3.0
    book31.added_at = Date()
    book31.started_on = formatter.date(from: "2020/07/11")
    book31.finished_on = formatter.date(from: "2020/07/15")
    
    let book32 = Book.mr_createEntity()!
    book32.title = "Siete días de julio"
    book32.subtitle = "(Inspector Mascarell #Volumen 2)"
    book32.authors = Set([author30]) as NSSet
    book32.isbn = 9788499087610
    book32.publisher = "Debolsillo"
    book32.image = "https://imagessl0.casadellibro.com/a/l/t0/10/9788499087610.jpg"
    book32.reading_state = "Terminado"
    book32.rate = 3.0
    book32.added_at = Date()
    book32.started_on = formatter.date(from: "2020/07/17")
    book32.finished_on = formatter.date(from: "2020/07/21")
    
    let book33 = Book.mr_createEntity()!
    book33.title = "El Zorro"
    book33.authors = Set([author31]) as NSSet
    book33.isbn = 9788401021848
    book33.publisher = "Penguin Random House Grupo Editorial España"
    book10.image = "https://m.media-amazon.com/images/I/917eTp+0D4L._AC_UY218_.jpg"
    book33.reading_state = "Terminado"
    book33.rate = 2.5
    book33.added_at = Date()
    book33.started_on = formatter.date(from: "2020/07/22")
    book33.finished_on = formatter.date(from: "2020/07/30")
    
    let book34 = Book.mr_createEntity()!
    book34.title = "Cinco días de octubre"
    book34.subtitle = "(Inspector Mascarell #Volumen 3)"
    book34.authors = Set([author30]) as NSSet
    book34.isbn = 9788499894324
    book34.publisher = "Debolsillo"
    book34.image = "https://img1.od-cdn.com/ImageType-400/5835-1/F3F/9C0/38/%7BF3F9C038-D36A-418C-B8FA-050B41047787%7DImg400.jpg"
    book34.reading_state = "Terminado"
    book34.rate = 3.0
    book34.added_at = Date()
    book34.started_on = formatter.date(from: "2020/07/30")
    book34.finished_on = formatter.date(from: "2020/08/05")
    
    let book35 = Book.mr_createEntity()!
    book35.title = "Nunca Seré Tuya / You Don't Own Me"
    book35.authors = Set([author32, author33]) as NSSet
    book35.isbn = 9788466351317
    book35.publisher = "Penguin Random House Grupo Editorial España"
    book10.image = "https://m.media-amazon.com/images/I/817vfFlEstL._AC_UY218_.jpg"
    book35.reading_state = "Terminado"
    book35.rate = 3.0
    book35.added_at = Date()
    book35.started_on = formatter.date(from: "2020/08/06")
    book35.finished_on = formatter.date(from: "2020/08/13")
    
    let book36 = Book.mr_createEntity()!
    book36.title = "El lejano país de los estanques"
    book36.authors = Set([author36]) as NSSet
    book36.isbn = 9788423353798
    book36.publisher = "Ediciones Destino"
    book36.image = "http://images.amazon.com/images/P/8423353796.01Z.jpg"
    book36.reading_state = "Terminado"
    book36.rate = 3.0
    book36.added_at = Date()
    book36.started_on = formatter.date(from: "2020/08/13")
    book36.finished_on = formatter.date(from: "2020/08/20")
    
    let book37 = Book.mr_createEntity()!
    book37.title = "Dos días de mayo"
    book37.subtitle = "(Inspector Mascarell #Volumen 4)"
    book37.authors = Set([author30]) as NSSet
    book37.isbn = 9788490327326
    book37.publisher = "Penguin Random House Grupo Editorial España"
    book37.image = "http://images.amazon.com/images/P/8490327327.01Z.jpg"
    book37.reading_state = "Terminado"
    book37.rate = 3.0
    book37.added_at = Date()
    book37.started_on = formatter.date(from: "2020/08/13")
    book37.finished_on = formatter.date(from: "2020/08/23")
    
    let book38 = Book.mr_createEntity()!
    book38.title = "El alquimista impaciente"
    book38.authors = Set([author36]) as NSSet
    book38.isbn = 9788423344260
    book38.publisher = "Ediciones Destino"
    book10.image = "https://m.media-amazon.com/images/I/71sIDVBP21L._AC_UY218_.jpg"
    book38.reading_state = "Terminado"
    book38.rate = 3.0
    book38.added_at = Date()
    book38.started_on = formatter.date(from: "2020/08/24")
    book38.finished_on = formatter.date(from: "2020/08/27")
    
    let book39 = Book.mr_createEntity()!
    book39.title = "Steve Jobs"
    book39.authors = Set([author37]) as NSSet
    book39.isbn = 9788499921181
    book39.publisher = "Debate"
    book10.image = "https://m.media-amazon.com/images/I/81HjRImNHcL._AC_UY218_.jpg"
    book39.reading_state = "Terminado"
    book39.rate = 3.0
    book39.added_at = Date()
    book39.started_on = formatter.date(from: "2020/08/27")
    book39.finished_on = formatter.date(from: "2020/09/06")
    
    let book40 = Book.mr_createEntity()!
    book40.title = "Seis días de diciembre"
    book40.subtitle = "(Inspector Mascarell #5)"
    book40.authors = Set([author30]) as NSSet
    book40.isbn = 9788490623879
    book40.publisher = "Penguin Random House Grupo Editorial España"
    book40.image = "http://images.amazon.com/images/P/8490623872.01Z.jpg"
    book40.reading_state = "Terminado"
    book40.rate = 3.0
    book40.added_at = Date()
    book40.started_on = formatter.date(from: "2020/09/08")
    book40.finished_on = formatter.date(from: "2020/09/15")
    
    let book41 = Book.mr_createEntity()!
    book41.title = "La niebla y la doncella"
    book41.authors = Set([author36]) as NSSet
    book41.isbn = 9788423344284
    book41.publisher = "Destino"
    book10.image = "https://m.media-amazon.com/images/I/81juyIqMeoL._AC_UY218_.jpg"
    book41.reading_state = "Terminado"
    book41.rate = 3.0
    book41.added_at = Date()
    book41.started_on = formatter.date(from: "2020/09/15")
    book41.finished_on = formatter.date(from: "2020/09/22")
    
    let book42 = Book.mr_createEntity()!
    book42.title = "Nueve días de abril"
    book42.subtitle = "(Inspector Mascarell #6)"
    book42.authors = Set([author30]) as NSSet
    book42.isbn = 9788466329941
    book42.publisher = "Penguin Random House Grupo Editorial España"
    book42.image = "https://imagessl1.casadellibro.com/a/l/t5/41/9788466329941.jpg"
    book42.reading_state = "Terminado"
    book42.rate = 3.0
    book42.added_at = Date()
    book42.started_on = formatter.date(from: "2020/09/22")
    book42.finished_on = formatter.date(from: "2020/09/28")
    
    let book43 = Book.mr_createEntity()!
    book43.title = "El mensaje de Pandora"
    book43.authors = Set([author25]) as NSSet
    book43.isbn = 9788408232032
    book43.publisher = "PLANETA"
    book43.image = "https://covers.openlibrary.org/b/id/10201107-L.jpg"
    book43.reading_state = "Terminado"
    book43.rate = 2.5
    book43.added_at = Date()
    book43.started_on = formatter.date(from: "2020/09/28")
    book43.finished_on = formatter.date(from: "2020/09/30")
    
    let book44 = Book.mr_createEntity()!
    book44.title = "Tres días de agosto"
    book44.subtitle = "(Inspector Mascarell #7)"
    book44.authors = Set([author30]) as NSSet
    book44.isbn = 9788466339582
    book44.publisher = "Penguin Random House Grupo Editorial España"
    book44.image = "http://images.amazon.com/images/P/8466339582.01Z.jpg"
    book44.reading_state = "Terminado"
    book44.rate = 3.0
    book44.added_at = Date()
    book44.started_on = formatter.date(from: "2020/10/10")
    book44.finished_on = formatter.date(from: "2020/10/14")
    
    let book45 = Book.mr_createEntity()!
    book45.title = "La novia gitana"
    book45.authors = Set([author38]) as NSSet
    book45.isbn = 9788420433189
    book45.publisher = "Alfaguara"
    book45.image = "https://covers.openlibrary.org/b/id/8179815-L.jpg"
    book45.reading_state = "Terminado"
    book45.rate = 5.0
    book45.added_at = Date()
    book45.started_on = formatter.date(from: "2020/11/03")
    book45.finished_on = formatter.date(from: "2020/11/08")
    
    let book46 = Book.mr_createEntity()!
    book46.title = "La superación de la indiferencia"
    book46.subtitle = "El sentido de la vida en tiempos de cambio"
    book46.authors = Set([author39]) as NSSet
    book46.isbn = 9788425443558
    book46.publisher = "Herder Editorial"
    book46.image = "http://img2.peruebooks.com/covers/covers-3/9788425443558.jpg"
    book46.reading_state = "Terminado"
    book46.rate = 2.5
    book46.added_at = Date()
    book46.started_on = formatter.date(from: "2020/11/07")
    book46.finished_on = formatter.date(from: "2020/11/11")
    
    let book47 = Book.mr_createEntity()!
    book47.title = "El poder de confiar en ti"
    book47.subtitle = "Aprende a tener fe en ti y conseguirás lo que quieras"
    book47.authors = Set([author40]) as NSSet
    book47.isbn = 9788408205630
    book47.publisher = "Editorial Planeta"
    book47.image = "https://covers.openlibrary.org/b/id/10298885-L.jpg"
    book47.reading_state = "Terminado"
    book47.rate = 2.5
    book47.added_at = Date()
    book47.started_on = formatter.date(from: "2020/10/15")
    book47.finished_on = formatter.date(from: "2020/11/14")
    
    let book48 = Book.mr_createEntity()!
    book48.title = "Rey blanco"
    book48.authors = Set([author18]) as NSSet
    book48.isbn = 9788466668545
    book48.publisher = "B (Ediciones B)"
    book48.image = "https://covers.openlibrary.org/b/id/10508453-L.jpg"
    book48.reading_state = "Terminado"
    book48.rate = 5.0
    book48.added_at = Date()
    book48.started_on = formatter.date(from: "2020/11/14")
    book48.finished_on = formatter.date(from: "2020/11/16")
    
    let book49 = Book.mr_createEntity()!
    book49.title = "La suerte del enano"
    book49.authors = Set([author41]) as NSSet
    book49.isbn = 9788491294603
    book49.publisher = "SUMA"
    book10.image = ""
    book49.reading_state = "Terminado"
    book49.rate = 4.0
    book49.added_at = Date()
    book49.started_on = formatter.date(from: "2020/12/19")
    book49.finished_on = formatter.date(from: "2020/12/25")
    
    let book50 = Book.mr_createEntity()!
    book50.title = "El Paciente"
    book50.authors = Set([author18]) as NSSet
    book50.isbn = 0
    book50.publisher = "B (Ediciones B)"
    book10.image = ""
    book50.reading_state = "Terminado"
    book50.rate = 5.0
    book50.added_at = Date()
    book50.started_on = formatter.date(from: "2021/01/05")
    book50.finished_on = formatter.date(from: "2021/01/09")
    
    // Persist in Core Data
    NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
  }
  
  class func updateImages (){
    
//    var book : Book?
      
//    Book.mr_findFirst(byAttribute: "isbn", withValue: "9788423344284")
//    book?.image = "https://m.media-amazon.com/images/I/81juyIqMeoL._AC_UY218_.jpg"
//
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788499921181")
//    book?.image = "https://m.media-amazon.com/images/I/81HjRImNHcL._AC_UY218_.jpg"
//
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788423344260")
//    book?.image = "https://m.media-amazon.com/images/I/71sIDVBP21L._AC_UY218_.jpg"
//
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788466351317")
//    book?.image = "https://m.media-amazon.com/images/I/817vfFlEstL._AC_UY218_.jpg"
//
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788401021848")
//    book?.image = "https://m.media-amazon.com/images/I/917eTp+0D4L._AC_UY218_.jpg"
//
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788479532536")
//    book?.image = "https://m.media-amazon.com/images/I/71mVri6PDWL._AC_UY218_.jpg"
//
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788478086085")
//    book?.image = "https://m.media-amazon.com/images/I/71WDmR4x0zL._AC_UY218_.jpg"
    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788483464113")
//    book?.image = "https://imagessl3.casadellibro.com/a/l/t7/13/9788483464113.jpg"
    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788466347396")
//    book?.image = "https://m.media-amazon.com/images/I/A1tHTnqbf+L._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788466666497")
//    book?.image = "https://m.media-amazon.com/images/I/81K62Fg+E3L._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788497778213")
//    book?.image = "https://m.media-amazon.com/images/I/81wX0gJlorL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788499083278")
//    book?.image = "https://m.media-amazon.com/images/I/41LPoQCwQCL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788466664417")
//    book?.image = "https://m.media-amazon.com/images/I/71GC9IBeQjL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9781719587211")
//    book?.image = "https://m.media-amazon.com/images/I/71h05twjbRL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788499926223")
//    book?.image = "https://m.media-amazon.com/images/I/81sBQfVzziL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788499890944")
//    book?.image = "https://m.media-amazon.com/images/I/81HSpSoddtL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788499083209")
//    book?.image = "https://m.media-amazon.com/images/I/41lmBpTOuRL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788432902154")
//    book?.image = "https://m.media-amazon.com/images/I/81jzLULtuvL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788415505860")
//    book?.image = "https://m.media-amazon.com/images/I/71z1ZMShiiL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788496981522")
//    book?.image = "https://m.media-amazon.com/images/I/81eh6kvO9sL._AC_UY218_.jpg"
//    
//    book = Book.mr_findFirst(byAttribute: "isbn", withValue: "9788492921850")
//    book?.image = "https://m.media-amazon.com/images/I/71gi1nWVCVL._AC_UY218_.jpg"
    
    NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
  }
}
