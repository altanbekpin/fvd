from enum import Enum
class Alphabet:
    class Vowels(Enum):
        а = 1
        ә = 2
        е = 3
        и = 4
        о = 5
        ө = 6
        ұ = 7
        ү = 8
        у = 9
        ы = 10
        і = 11
        э = 12

    class Consonants(Enum):
        б = 1
        в = 2
        г = 3
        ғ = 4
        д = 5
        ж = 6
        з = 7
        й = 8
        к = 9
        қ = 10
        л = 11
        м = 12
        н = 13
        ң = 14
        п = 15
        р = 16
        с = 17
        т = 18
        у = 19
        ф = 20
        х = 21
        һ = 22
        ц = 23
        ч = 24
        ш = 25
        щ = 26

    class JuanDauysty(Enum):
        а = 1
        о = 2
        ұ = 3
        ы = 4

    class JiniskeDauysty(Enum):
        ә = 1
        ө = 2
        ү = 3
        i = 4
        е = 5

    class Catan(Enum):
        п = 1
        к = 2
        қ = 3
        т = 4
        с = 5
        ф = 6
        х = 7
        ц = 8
        ч = 9
        ш = 10

    class Uyan(Enum):
        б = 1
        в = 2
        г = 3
        ғ = 4
        д = 5
        ж = 6
        з = 7

    class Undi(Enum):
        м = 1
        л = 2
        н = 3
        ң = 4

    class Exceptions(Enum):
        р = 1
        й = 2
        у = 3

    class UndiJalgatynDybystar(Enum):
        с = 1
        ш = 2
        д = 3
        г = 4
        ғ = 5
        м = 6
