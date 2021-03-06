<?php

namespace Brazda;

trait Encoding {

    public static function toAscii($text)
    {
        return str_replace(
            ['ǎ', 'á', 'ä',
             'ě', 'é', 'ë',
             'ǐ', 'í', 'ï',
             'ǒ', 'ó', 'ö',
             'ů', 'ú', 'ů', 'ü',
             'ý', 'ÿ',
             'š', 'ś',
             'č', 'ć',
             'ř', 'ŕ',
             'ž', 'ź',
             'ď',
             'ť',
             'ň', 'ń',
             'ľ', 'ĺ',

             'Ǎ', 'Á', 'Ä',
             'Ě', 'É', 'Ë',
             'Ǐ', 'Í', 'Ï',
             'Ǒ', 'Ó', 'Ö',
             'Ů', 'Ú', 'Ů', 'Ü',
             'Ý', 'Ÿ',
             'Š', 'Ś',
             'Č', 'Ć',
             'Ř', 'Ŕ',
             'Ž', 'Ź',
             'Ď',
             'Ť',
             'Ň', 'Ń',
             'Ľ', 'Ĺ'],

             ['a', 'a', 'a',
              'e', 'e', 'e',
              'i', 'i', 'i',
              'o', 'o', 'o',
              'u', 'u', 'u', 'u',
              'y', 'y',
              's', 's',
              'c', 'c',
              'r'. 'r',
              'z', 'z',
              'd',
              't',
              'n', 'n',
              'l', 'l',

              'A', 'A', 'A',
              'E', 'E', 'E',
              'I', 'I', 'I',
              'O', 'O', 'O',
              'U', 'U', 'U', 'U',
              'Y', 'Y',
              'S', 'S',
              'C', 'C',
              'R', 'R',
              'Z', 'Z',
              'D',
              'T',
              'N', 'N',
              'L', 'L'],
            $text
        ); // str_replace()
    } // toAscii()

} // Encoding
