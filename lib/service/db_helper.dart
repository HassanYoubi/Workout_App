import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:workout_app/classes/categorie.dart';
import 'package:workout_app/classes/exercice.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      String pathDB = join(await getDatabasesPath(), 'musculationdb.db');
      _db = await openDatabase(pathDB, version: _version, onCreate: onCreate);
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
    }
  }

  static Future<FutureOr<void>> onCreate(Database db, int version) async {
    //La table categories
    String sqlQuery =
        'CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT, image TEXT)';
    await db.execute(sqlQuery);
    //La table exercices
    String sqlExercice =
        'CREATE TABLE exercices (id INTEGER PRIMARY KEY AUTOINCREMENT, ';
    sqlExercice +=
        'titre STRING, image STRING, temps INTEGER, repetition INTEGER, ';
    sqlExercice += 'categorieId INTEGER, description STRING, video String)';
    await db.execute(sqlExercice);
    // insertion des données
    await insererDonnees(db);
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    return _db!.query(table);
  }

  static Future<int> insert(String table, Exercice model) async {
    return await _db!.insert(
      table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> reqExercicesByCategorie(
      int categorieId) async {
    return await _db!.rawQuery(
        'SELECT * FROM ${Exercice.table} WHERE categorieId = ?', [categorieId]);
  }

  static Future<int> update(String table, Exercice model) async {
    return await _db!.update(
      table,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  static Future<int> delete(String table, int id) async {
    return await _db!.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> insererDonnees(Database db) async {
    //  insert categories
    // Category({this.id, this.name, this.image});
    final _tableName = Exercice.table;
    final _categoryTable = Categorie.table;
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [1, 'abdominaux', 'assets/images/categories/abdominaux.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [2, 'biceps', 'assets/images/categories/biceps.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [3, 'cuisses', 'assets/images/categories/cuisses.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [4, 'dos', 'assets/images/categories/dos.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [5, 'epaules', 'assets/images/categories/epaules.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [6, 'mollets', 'assets/images/categories/mollets.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [7, 'parties', 'assets/images/categories/parties.jpg']);
    await db.execute("INSERT INTO $_categoryTable values (?, ?, ?)",
        [8, 'triceps', 'assets/images/categories/triceps.jpg']);

    //insert exercises data
    //Exercise({this.id, this.titre, this.image, this.temps, this.repetition, this.categorieId, this.description, this.video});
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'crunch-au-sol',
          'assets/images/exercices/abdominaux/crunch-au-sol.jpg',
          9,
          11,
          1,
          "Le crunch est un exercice simple et efficace pour muscler les abdominaux. Il affine et raffermit la taille si vous travaillez avec le poids du corps, et développe les abdominaux si vous utilisez un lest de plus en plus lourd. Il ne nécessite pas de matériel et peut être réalisé n’importe où.",
          'https://www.youtube.com/watch?v=zUk1BiL6Ajc'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'crunch-poulie',
          'assets/images/exercices/abdominaux/crunch-poulie.jpg',
          18,
          23,
          1,
          "Le crunch à la corde effectué sur la poulie haute est un exercice très efficace pour travailler la sangle abdominale. Il consiste à enrouler le buste vers l'avant en tirant sur la poulie, ce qui reproduit le mouvement du crunch classique, mais à la verticale.",
          'https://www.youtube.com/watch?v=UZBfM_p3138'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'flexions-machine',
          'assets/images/exercices/abdominaux/flexions-machine.jpg',
          11,
          21,
          1,
          "Avoir des abdominaux musclés n'est pas seulement un avantage esthétique, c'est aussi d'une grande importance pour améliorer vos performances dans d'autres exercices de musculation et dans des sports parallèles. Cela permet également de prévenir les problèmes de dos. C'est pourquoi il existe de nombreux exercices pour travailler les abdominaux et, parmi eux, les flexions du buste à la machine. Cette dernière est équipée d'un dossier et de poignées qui aident à effectuer le mouvement correctement. Il est aussi possible d'ajouter du poids à l'exercice.",
          'https://www.youtube.com/watch?v=UYfuax8KwcE'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'releve-genoux',
          'assets/images/exercices/abdominaux/releve-genoux.jpg',
          7,
          10,
          1,
          "Cet exercice de musculation des abdominaux est souvent réalisé sur une chaise romaine, un appareil qu’on trouve dans la plupart des salles de musculation. Il raffermit et muscle la taille, les abdominaux mais aussi les fléchisseurs de la hanche.",
          'https://www.youtube.com/watch?v=2_3aOp6j9m8'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'curl-barre',
          'assets/images/exercices/biceps/curl-barre.jpg',
          17,
          24,
          2,
          "Cet exercice de musculation sollicite et développe les biceps. Le curl barre est l’exercice d’isolation de base pour les biceps.",
          'https://www.youtube.com/watch?v=ZLRBO5wiPwM'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'curl-concentration',
          'assets/images/exercices/biceps/curl-concentration.jpg',
          13,
          16,
          2,
          "Cet exercice de musculation sollicite et développe les biceps. Le curl en concentration est un exercice d'isolation qui va vous permettre de peaufiner vos bras. Les curls à la barre ou aux haltères sont les exercices de musculation de base bien utiles pour développer la massse de vos biceps et obtenir des gros bras. Vous devrez donc les privilégier. Ils pourront éventuellement être complétés par du curl concentration pour diversifier l'entraînement des biceps. Cet exercice à la réputation de développer le « pic » du biceps.",
          'https://www.youtube.com/watch?v=AeHpcMxhqgI'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'curl-haltere',
          'assets/images/exercices/biceps/curl-haltere.jpg',
          9,
          10,
          2,
          "Cet exercice de musculation sollicite et développe les biceps. Les haltères permettent pas mal de variantes intéressantes.",
          'https://www.youtube.com/watch?v=dh6Tcwy9a_o'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'curl-incline',
          'assets/images/exercices/biceps/curl-incline.jpg',
          7,
          13,
          2,
          "Le Curl Incliné est une variante du curl classique qui, comme ce dernier, est un exercice d'isolation ciblant principalement le travail des biceps.",
          'https://www.youtube.com/watch?v=jKaODf3rvHE'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'curl-pupitre',
          'assets/images/exercices/biceps/curl-pupitre.jpg',
          8,
          9,
          2,
          "Ce type de curl est effectué sur une machine, munie d'un pupitre, qu'on nomme aussi pupitre Larry Scott, du nom du célèbre bodybuilder. C'est un exercice d'isolation pour les biceps qui sollicite mieux le brachial que les curls effectués de façon classique. De plus, la machine exerce une tension continue et uniforme durant tout le mouvement et limite la triche, ce qui oblige à conserver une technique propre.",
          'https://www.youtube.com/watch?v=quZzNBrYBxw'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'front-squat',
          'assets/images/exercices/cuisses/front-squat.jpg',
          12,
          21,
          3,
          "Basculez légèrement le bassin vers l’arrière, ce qui devrait créer une faible cambrure de votre dos et vous aidera à éviter de faire le dos rond. Fléchissez les genoux afin de descendre la barre vers le sol, tout en contrôlant le mouvement. Continuez jusqu’à ce que vos cuisses soient horizontales au sol.",
          'https://www.youtube.com/watch?v=i7I9plJeeNs'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'hack-squat',
          'assets/images/exercices/cuisses/hack-squat.jpg',
          12,
          9,
          3,
          "Cet exercice de musculation sollicite et développe les muscles des cuisses et les fessiers. Si vous avez tendance à tout prendre dans les fessiers, ce mouvement est fait pour vous ! Il fait plus travailler les quadriceps et moins les fessiers. C'est une bonne alternative au squat à la barre, un exercice certes efficace mais qui ne convient pas à tout le monde.",
          'https://www.youtube.com/watch?v=5gW-f95w_NA'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'presse-cuisses',
          'assets/images/exercices/cuisses/presse-cuisses.jpg',
          12,
          16,
          3,
          "Expirez en poussant. Avec des charges lourdes, expirez juste après avoir passé le point de blocage. La respiration bloquée avec les abdominaux contractés permettent d'avoir une bonne position en gainant le tronc dans la partie difficile du mouvement où l'on peut bloquer.",
          'https://www.youtube.com/watch?v=Ef1wVCbLWN0'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'programme-cuisses',
          'assets/images/exercices/cuisses/programme-cuisses.jpg',
          16,
          23,
          3,
          "Cet exercice de musculation sollicite et développe l’ensemble du corps mais vise principalement les muscles des cuisses et les fessiers. C'est l'exercice roi de la musculation. « Ceux qui ne font pas de squat, ne font pas de musculation » est une expression qu'on entend souvent de la bouche des culturistes. Assez technique, il demande un bon équilibre et une certaine souplesse. Efficace et rentable, il ne convient pas à toutes les morphologies qui tireront plus de bénéfices d'autres exercices.",
          'https://www.youtube.com/watch?v=fypQ8tQ1OP0'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'squat-1-jambe',
          'assets/images/exercices/cuisses/squat-1-jambe.jpg',
          9,
          19,
          3,
          "Cet exercice de musculation sollicite les muscles des cuisses et les fessiers. Il est très efficace et excellent pour développer la coordination et l’équilibre, en plus de faire gagner du muscle aux cuisses et fessiers. Il s’exécute de la même façon que le squat mais sur une seule jambe. Il convient parfaitement à ceux qui n’ont pas ou très peu de matériel, à ceux qui ont des problèmes au dos et qui ne peuvent pas faire de squat à la barre. C'est d'ailleurs sur cet exercice que les pratiquants de la méthode Lafay construisent leurs cuisses.",
          'https://www.youtube.com/watch?v=xjvr3aySTuk'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'tirage-devant',
          'assets/images/exercices/dos/tirage-devant.jpg',
          8,
          18,
          4,
          "Cet exercice de musculation sollicite les muscles du dos au niveau de la largeur. Le travail à la poulie haute permet à ceux qui ne sont pas encore capables de faire des tractions sur la barre fixe avec le poids du corps, d’exercer les dorsaux.",
          'https://www.youtube.com/watch?v=9fEGXlAOC8g'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'tirage-nuque',
          'assets/images/exercices/dos/tirage-nuque.jpg',
          7,
          12,
          4,
          "Cet exercice de musculation sollicite les muscles du dos surtout au niveau de la largeur. Le travail à la poulie haute permet à ceux qui ne sont pas encore capable de faire des tractions à la barre fixe avec leur poids du corps, de muscler leur dos en largeur.",
          'https://www.youtube.com/watch?v=uq8OXMuU4_o'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'tirage-serre',
          'assets/images/exercices/dos/tirage-serre.jpg',
          11,
          18,
          4,
          "Cet exercice de musculation sollicite les muscles du dos. Le travail à la poulie haute est intéressant quand il n'est pas possible de faire des tractions à la barre fixe, avec le poids du corps. On peut facilement régler la charge de départ avec un poids qui correspond à notre niveau de force, et l'augmenter au fur et à mesure des progrès. La prise serrée sollicite surtout le grand dorsal, le grand rond et bien sûr les biceps.",
          'https://www.youtube.com/watch?v=PPfFlbmyTGw'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'tractions',
          'assets/images/exercices/dos/tractions.jpg',
          9,
          19,
          4,
          "Cet exercice de musculation sollicite et développe les muscles du dos, surtout au niveau de la largeur. Les tractions à la barre fixe sont de formidables bâtisseuses de dorsaux. En tant que mouvement de base, nous vous conseillons de l'inclure dans votre routine de dos. Ceux qui ne peuvent pas faire de tractions avec le poids du corps pourront se diriger vers les tirages à la poulie haute.",
          'https://www.youtube.com/watch?v=OnKLnb2vsPI'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'trapezes',
          'assets/images/exercices/dos/trapezes.jpg',
          10,
          16,
          4,
          "Cet exercice de musculation sollicite et développe les trapèzes. Ces grands muscles en éventail sont situés sur le haut du dos et recouvrent toute la partie supérieure du cou et du dos.",
          'https://www.youtube.com/watch?v=w9Li8JTpqFE'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'developpe-devant',
          'assets/images/exercices/epaules/developpe-devant.jpg',
          8,
          19,
          5,
          "Les développés sont parfaits pour se forger des épaules massives. Le développé devant renforce les muscles des épaules, surtout l'avant et le côté, et indirectement le haut des pectoraux et les triceps. C’est un exercice polyarticulaire très complet qui vous donnera plus de gains musculaires et de force que les exercices d’isolation comme les élévations frontales ou latérales. La version barre devant ou aux haltères sont deux des meilleurs exercices pour les épaules, aussi bien pour les débutants que les confirmés.",
          'https://www.youtube.com/watch?v=enT4QOuE_4I'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'developpe-nuque',
          'assets/images/exercices/epaules/developpe-nuque.jpg',
          7,
          21,
          5,
          "Cet exercice de musculation sollicite les épaules. Les développés sont des mouvements basiques, très efficaces pour se forger de bonnes épaules. Dans cette variante de développé, on descend la barre verticalement derrière la nuque, jusqu'au niveau des oreilles. L'objectif est de cibler le côté et l'arrière de l'épaule, par rapport au développé par devant qui lui cible plutôt l'avant.",
          'https://www.youtube.com/watch?v=HYT-voEyjrE'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'elevations-laterales',
          'assets/images/exercices/epaules/elevations-laterales.jpg',
          10,
          16,
          5,
          "Cet exercice de musculation sollicite les épaules, plus particulièrement le faisceau latéral, sur le côté, qui donne la fameuse largeur d’épaule tant recherchée. Il est vrai que la carrure est la première chose que l'on remarque quand on croise quelqu'un dans la rue. Larges et bien galbées, de bonnes épaules vous mettent en valeur habillé. Plus besoin de rembourrage ou d'épaulettes pour accentuer la carrure de son costume ! Disons-le, des épaules au top, énormes et sèches, ça fait son effet ! Alors mieux vaut miser sur ce groupe musculaire clé et ne rien laisser au hasard…",
          'https://www.youtube.com/watch?v=zsFbSKCK4Hw'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'force-performance',
          'assets/images/exercices/epaules/force-performance.jpg',
          14,
          17,
          5,
          "Cet exercice de musculation sollicite les muscles des épaules, et indirectement les triceps – à l'arrière des bras – et le haut des pectoraux. C’est un exercice de base, idéal pour prendre de la masse, de l'épaisseur et construire des épaules massives.",
          'https://www.youtube.com/watch?v=L0z13X2C0UU'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'rowing-menton',
          'assets/images/exercices/epaules/rowing-menton.jpg',
          6,
          12,
          5,
          "Si vous voulez gagner de la largeur d'épaules et épaissir le haut de votre dos, alors le rowing menton devrait vous intéresser ! Cet exercice de musculation appelé qui consiste à faire un tirage vertical avec la barre en l'amenant jusqu'au menton, un « rowing menton », sollicite les muscles des épaules et les trapèzes indirectement.",
          'https://www.youtube.com/watch?v=ornlx3dGCCA'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'donkey',
          'assets/images/exercices/mollets/donkey.jpg',
          8,
          19,
          6,
          "Cet exercice de musculation sollicite les mollets, jumeaux et soléaire. Il est peu pratiqué en salle faute de machine spécifique ou de partenaire audacieux.  En effet, il est difficile de trouver un ou une partenaire qui accepte de vous monter dessus ! Il donne néanmoins de bonnes sensations sur les jumeaux. On peut le remplacer par l'exercice de mollets à la presse à cuisses.",
          'https://www.youtube.com/watch?v=zAgETfuU3nw'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'mollets',
          'assets/images/exercices/mollets/mollets.jpg',
          7,
          14,
          6,
          "Cet exercice de musculation renforce et développe les mollets, plus particulièrement les jumeaux tout au-dessus, du fait de la position james tendues. Les jumeaux sont constitués de fibres lentes et de fibres rapides, il faudra donc les travailler en séries longues et courtes. Il est préférable de commencer sa séance de mollets par les exercices de musculation comme les mollets debout et de finir par les exercices assis.",
          'https://www.youtube.com/watch?v=L_A3pFgYcA8'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'mollets-assis',
          'assets/images/exercices/mollets/mollets-assis.jpg',
          16,
          21,
          6,
          "Cet exercice de musculation sollicite le soléaire, un muscle puissant de la jambe qui permet l'extension du pied. Les muscles soléaires, très résistants, sont essentiellement constitués de fibres lentes. Il faudra donc travailler en séries plutôt longues. Il est préférable de commencer sa séance de mollets par les exercices de musculation ou les jambes sont tendues comme les mollets debout, et finir par les exercices assis",
          'https://www.youtube.com/watch?v=hEXn35mkkWI'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'mollets-presse',
          'assets/images/exercices/mollets/mollets-presse.jpg',
          11,
          15,
          6,
          "Cet exercice de musculation sollicite les mollets, jumeaux et soléaire. Les sensations musculaires sont très différentes du fait de la position sur la machine. La presse à cuisse est très sécuritaire et utile pour les personnes qui ont des problèmes de dos et qui ne peuvent pas pratiquer les exercices où une charge écrase la colonne vertébrale comme aux mollets debout.",
          'https://www.youtube.com/watch?v=xZJtQOdNbKk'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'curl-gironda',
          'assets/images/exercices/parties/curl-gironda.jpg',
          9,
          15,
          7,
          "Vince Gironda est un culturiste des années 50, considéré à l’époque comme l'un des meilleurs entraîneurs de bodybuilding.Vince avait des méthodes d’entraînement peu orthodoxes. Le développé couché était pour lui un exercice de musculation peu intéressant, qui donne des poitrines inesthétiques en forme de seins de femme ; pas larges et plates comme une cuirasse de gladiateur. Pour cela, il faisait faire à ses élèves des dips d’une manière très spéciale, les fameuses « dips Gironda », dans le but d’obtenir des pectoraux avec une forme classique.",
          'https://www.youtube.com/watch?v=hhpFhpafkXo'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'dch',
          'assets/images/exercices/parties/dch.jpg',
          11,
          15,
          7,
          "Le développé couché est un exercice de base pour cibler les pectoraux. Il peut s'exécuter avec une barre ou sur machine. Mais, avec des haltères, il possède l’intérêt de permettre un mouvement plus naturel, une meilleure contraction des pectoraux et un plus grand étirement des muscles.",
          'https://www.youtube.com/watch?v=e1alt1rt0Tw'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'developpe-assis',
          'assets/images/exercices/parties/developpe-assis.jpg',
          12,
          24,
          7,
          "Le développé assis à la machine ou « presse à pectoraux », est une alternative au développé couché à la barre ou aux haltères, qui présente l'avantage d'être sécurisé et donc de permettre un travail plus lourd.",
          'https://www.youtube.com/watch?v=YHaXgBGwMAg'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'developpe-couche',
          'assets/images/exercices/parties/developpe-couche.jpg',
          11,
          13,
          7,
          "Cet exercice de musculation très populaire développe la poitrine. Le développe couché est un exercice de base qui fait intervenir deux articulations (coude et épaule) et qui permet de travailler l'ensemble du buste, pas seulement les pectoraux. C'est un des mouvement qui permet d'évaluer la force musculaire des membres supérieurs et qui est utilisé dans les épreuves de force athlétique.",
          'https://www.youtube.com/watch?v=1_k-ChdhzOos'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'dev-couche-smit',
          'assets/images/exercices/parties/developpe-couche-smit.jpg',
          8,
          18,
          7,
          "Le développé couché à la smith machine est une variante du développé couché classique qui se pratique grâce à un cadre guidé. Ce cadre a l'avantage de sécuriser le mouvement et donc de limiter les accidents. Mais, cela permet aussi de mieux se concentrer sur la travail des pectoraux, de se passer de partenaire et de travailler lourd et/ou à l'échec.",
          'https://www.youtube.com/watch?v=B4_roJacJTQ'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'dive',
          'assets/images/exercices/parties/dive.jpg',
          12,
          20,
          7,
          "Beaucoup de choses ont été écrites sur les pompes, et vous connaissez probablement toutes les variantes de cet exercice surtout si vous êtes un adepte des mouvements au poids du corps. Les pompes sont un des meilleurs exercices de musculation pour remodeler les muscles du buste sans nécessiter le moindre matériel.",
          'https://www.youtube.com/watch?v=GJUroK37U28'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'ecarte-couche',
          'assets/images/exercices/parties/ecarte-couche.jpg',
          15,
          27,
          7,
          "Cet exercice de musculation d'isolation permet de travailler les pectoraux. Il minimise l'intervention des épaules (deltoïde antérieur) et ne sollicite quasi pas les triceps. On pourra le placer en fin de séance comme exercice de finition des pectoraux.",
          'https://www.youtube.com/watch?v=KukuR7vMYnc'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'muscule-pompes',
          'assets/images/exercices/parties/musculaction-pompes.jpg',
          8,
          18,
          7,
          " On peut se construire de bons pectoraux avec seulement les pompes mais à condition de savoir s'y prendre pour bien développer toutes les parties de ce groupe musculaire. En effet, selon la position des mains et l'inclinaison, on pourra favoriser le haut, le bas ou même l'intérieur des pectoraux.",
          'https://www.youtube.com/watch?v=3XkA5q8bM1k'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'pec-deck',
          'assets/images/exercices/parties/pec-deck.jpg',
          5,
          9,
          7,
          "Cet exercice de musculation sollicite les pectoraux. C'est un exercice d'isolation qui permet de travailler sur une grande amplitude. Très apprécié par les débutants, le « butterfly » finalise généralement la session de pectoraux après les mouvements de base. Si vous travaillez en séries assez longues, il vous procurera de très bonnes sensations et une congestion intense.",
          'https://www.youtube.com/watch?v=iaFzPXaPLHo'
        ]);

    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'barre-front',
          'assets/images/exercices/triceps/barre-front.jpg',
          7,
          8,
          8,
          "Cet exercice de musculation développe la masse et la force des triceps, à l'arrière des bras. Dans le jargon de la musculation, on le surnomme « barre-front » du fait qu'on amène la barre au niveau du front durant la phase négative du mouvement. Il consiste à faire des extensions à la barre droite ou à la barre EZ (plus confortable pour les coudes et les poignets), couché sur un banc ou allongé sur le sol.",
          'https://www.youtube.com/watch?v=-a4FR3zmdJ8'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'DPS',
          'assets/images/exercices/triceps/dc-prise-serree.jpg',
          10,
          23,
          8,
          "Le développé couché prise serrée est une variante du développé couché standard qui met l'accent sur les triceps. C'est un des mouvements pour les triceps qui permet de porter les charges les plus lourdes.",
          'https://www.youtube.com/watch?v=0nvq9uWuKrM'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'extensions',
          'assets/images/exercices/triceps/extensions.jpg',
          7,
          22,
          8,
          "Cet exercice de musculation développe les muscles triceps qui se situe sur la face postérieure du bras. La position du bras au-dessus de la tête rend l'exercice plus difficile par rapport au barre-front ou au travail à la poulie haute. La charge utilisée sera donc moins importante.",
          'https://www.youtube.com/watch?v=kJ32PRK3LRo'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'kick-back',
          'assets/images/exercices/triceps/kick-back.jpg',
          8,
          15,
          8,
          "Cet exercice de musculation appelé « kick back » développe les triceps à l'arrière du bras. C'est un exercice de finition qu'on place généralement à la fin de la séance de triceps pour obtenir une bonne congestion dans ces muscles. On ne peut pas prendre très lourd sur cet exerice d'isolation, et ce n'est pas le but. L'objectif est de se concentrer sur les sensations musculaires.",
          'https://www.youtube.com/watch?v=uZZ2630ELp8'
        ]);
    await db.execute(
        "INSERT INTO $_tableName (titre, image, temps, repetition, categorieId, description, video) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          'poulie',
          'assets/images/exercices/triceps/poulie.jpg',
          6,
          12,
          8,
          "Cet exercice de musculation développe les triceps si vous utilisez des charges de plus en plus lourdes. C'est un exercice d'isolation simple mais pas aussi rentable en terme de gains musculaires que les exercices de base comme les dips ou les développés à la barre.",
          'https://www.youtube.com/watch?v=KzBZmv0UrWY'
        ]);
  }
}
