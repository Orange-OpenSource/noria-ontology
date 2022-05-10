/*
Copyright 2022 Bram Steenwinckel

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

Source: https://github.com/IBCNServices/Folio-Ontology/tree/master/generation_example
 */

import java.util.ArrayList;
import java.util.List;

public class DyversifyFunctions {

    public static String renson = "http://IBCNServices.github.io/Folio-Ontology/renson#";
    public static String m3lite = "http://purl.org/iot/vocab/m3-lite#";

    public static String generateIRI(String str, String prefix) {
        if (str == null || prefix == null) {
            return null;
        } else {
            String[] words = str.split(" ");

            for (int i = 0; i < words.length; i ++) {
                String word = words[i];

                word = word.substring(0, 1).toUpperCase() + word.substring(1);
                word = word.replaceAll("[^a-zA-Z0-9]", "");

                words[i] = word;
            }

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < words.length; i++) {
                strBuilder.append(words[i]);
            }

            String newString = strBuilder.toString();

            return prefix + newString;
        }
    }
}
