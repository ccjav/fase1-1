# Script: Single word converter to Pig Latin

# GET a word from user input
# IF the word starts with a vowel, add "way" to the end
# ELSE replace the word with its pig latin equivalent
#   GET all of the consonants before the first vowel in the word
#   SET the consonants at the end of the word and add "ay"
# ENDIF
# RETURN the pig-latin word
# Script: Sentence converter into Pig Latin

def single_word(word)
  if word[0] =~ /[aeiou]/i
    word + "way"
  else
    # nueva condicionante para palabras de puras consonantes sin vocales. ej: by
    if word.split(/([aeiou].*)/).length > 1
      # Parte palabra en 2 y lo mete en un array. 1er elemento es de consonat(es) iniciales, 2o la parte restante de la palabra a partir de e incluyendo la primera vocal
      word.split(/([aeiou].*)/)[1] + word.split(/([aeiou].*)/)[0] + "ay"
    else
      word.split(/([aeiou].*)/)[0]
    end
  end
end

# GET sentence from user input
# SPLIT sentence into an array of its words
# FOR each element of the array
#   DO single_word method
# ENDFOR
# JOIN words of array into a single string
# RETURN the pig latin sentence

def sentence(string)
  string.split.map { |word| single_word(word) }.join(' ')
end

p single_word("pig") == "igpay"
p single_word("banana") == "ananabay"
p single_word("trash") == "ashtray"
p single_word("happy") == "appyhay"
p single_word("duck") == "uckday"
p single_word("glove") == "oveglay"
p single_word("egg") == "eggway"
p single_word("apple") == "appleway"

p sentence("One morning, when Gregor Samsa woke from troubled dreams") == "Oneway orning,may enwhay egorGray amsaSay okeway omfray oubledtray eamsdray"
p sentence("he found himself transformed in his bed into a horrible vermin") == "ehay oundfay imselfhay ansformedtray inway ishay edbay intoway away orriblehay erminvay"
p sentence("He lay on his armour-like back") == "eHay aylay onway ishay armour-likeway ackbay"
p sentence("slightly domed and divided by arches into stiff sections") == "ightlyslay omedday andway ividedday by archesway intoway iffstay ectionssay"
p sentence("The bedding was hardly able to cover it and seemed ready to slide off any moment") == "eThay eddingbay asway ardlyhay ableway otay overcay itway andway eemedsay eadyray otay ideslay offway anyway omentmay"
p sentence("Pitifully thin compared with the size of the rest of him") == "itifullyPay inthay omparedcay ithway ethay izesay ofway ethay estray ofway imhay"
p sentence("It wasn't a dream") == "Itway asn'tway away eamdray"
p sentence("lay peacefully between its four familiar walls") == "aylay eacefullypay etweenbay itsway ourfay amiliarfay allsway"
