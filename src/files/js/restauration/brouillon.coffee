Comments = require './Comments'


(require './Comments').parse()

(require './Comments').parse('dddd')

(require './Comments').parse(['dddd','dfkdlfkld'])

normalizeKeys(commentaires:['dddd','dfkdlfkld'])

(require './Comments').parse(remarque:'ici')

(require './Comments').parse(commentaires:['dddd','dfkdlfkld','la'],remarque:['ici','la'])



MenuCourse = require './MenuCourse'

(require './MenuCourse').parse(
  entree: "Salade de tomates"
  plat: "Cordon bleu"
  legumes: "Tortis au gruyères/Haricots verts persillés"
  desserts: ["Ananas au sirop",'autre']
)


raw =
  entree: "Salade de tomates"
  plat: "Cordon bleu"
  legumes: "Tortis au gruyères/Haricots verts persillés"
  desserts: ["Ananas au sirop",'autre']


SchoolWeek = require './SchoolWeek'
SchoolMenuDay = require './SchoolMenuDay'

week = SchoolWeek.parse()

SchoolMenuDay.parse({
  lundi:
    entree: "Salade de tomates"
    plat: "Cordon bleu"
    legumes: "Tortis au gruyères/Haricots verts persillés"
    dessert: "Ananas au sirop"
  mardi:
    entree: "Concombres bulgares"
    plat: "Steack haché"
    legumes: "Pommes noisettes,Poêlée méridionale"
    desserts: "Compotes de fruits/Fruits"
  mercredi:
    entree: "Macédoine mayonnaise"
    plat: "Lasagnes bolognaise"
    legumes: "Salade verte"
    dessert: "Clémentines"
  jeudi:
    entree: "Betteraves mimosa"
    plat: "Sauté de porc à la provençale"
    legumes: "Semoule au jus/Gratin de brocolis"
    dessert: "Cookies"
  vendredi:
    entree:"Œufs durs mayonnaise"
    plat: "Dos de merlu blanc au basilic"
    legumes: "Riz safrané/Epinards à la crème"
    desserts: "Fromage blanc/Purée de framboise"
  tous:
    desserts: "Produits laitiers ou fromages"
},week)