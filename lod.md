# Linked Open Data

Modellierung der Litteratur-Tafel als Linked Open Data (LOD) mit Hilfe
anerkannter Vokabularien und existierender Wissensbasen (WikiData,
GND, ggf. DBpedia).

Herausforderungen:

- graphische Darstellung vs. dahinterliegender Graph - wie beides
  verknüpfen?

# Entwurf Struktur

## litteraturTafel

*abstrakte Beschreibung der Tafel mit Verweis auf konkrete Instanz*

- author CäsarFlaischlen
- year 1890
- instance [littaImage](#littaimage) *Soll auf eine konkrete
  Repräsentation verweisen (rja, 2016-11-08)*

## littaImage

*konkrete Instanz/Repräsentation der Tafel*

- mimeType PNG
- dimensions "x,y"
- hasURI URI
- contains [rectangle](#rectangle) *(Links zu den einzelnen Teilen,
  könnten wir weglassen)*

## person

*Auflistung aller in der Tafel erwähnten Personen*

- [rdfs:type](https://www.w3.org/TR/rdf-schema/#ch_type) [writer](https://www.wikidata.org/wiki/Q36180)
- [rdfs:label](https://www.w3.org/TR/rdf-schema/#ch_label) "Vorname Nachname"
- hasGND "id" *(könnten wir uns auch sparen, wenn wir schon zu WikiData
  verlinkt haben, da dort die GND ja verlinkt ist, rja, 2016-11-08)*
- [owl:sameAs](https://www.w3.org/TR/owl-ref/#sameAs-def) wikidataId
- mentionedIn [rectangle](#rectangle) *(ein erster Versuch, rja,
  2016-11-08)*
- influencedBy [influenceStatement](#influencestatement)

## rectangle

*eine BoundingBox für eine konkrete Person*

- partOf [littaImage](#littaimage)
- pos "x,y"
- size "h,w"
- mentions [person](#person)

## influenceStatement

*das entspräche ungefähr der Reifikations-Variante, wie sie bei
WikiData eingesetzt wird (rja, 2016-11-08)*

- rdfs:class wikidataStatement
- influencedBy otherPerson
- statedBy CäsarFlaischlen
- when "1890"

## influenceProperty

*das hier ist mir noch unklar, muss ich nochmal überarbeiten (rja, 2016-11-08)*

- rdfs:type influencedBy
- wikibase:claim influencedBy
- wikibase:StatementProperty influencedBy
