#include <iostream>
#include <vector>
using namespace std;

int herbs;
int hp_potion;
int mana_potion;
vector<string> swords;
int stockHerbs = 10;
int stockHp = 10;
int stockMana = 10;

void cobalagi();

void useHerbs() {
    cout << "Masukkan herbs: ";
    cin >> herbs;
    if (stockHerbs > 0) {
        herbs *= 10;
        stockHerbs -= 1;
    } else {
        cout << "Stock Herbs Habis. Silahkan beli Herbs terlebih dahulu" << endl;
    }
    cout << "Herbs mu adalah " << herbs << endl;
    cobalagi();
}

void useHPPotion() {
    cout << "Gunakan hp potion: ";
    cin >> hp_potion;
    if (stockHp > 0) {
        hp_potion *= 50;
        stockHp -= 1;
    } else {
        cout << "Stock Hp Potion Habis. Silahkan beli Herbs terlebih dahulu" << endl;
    }
    cout << "HP mu adalah " << hp_potion << endl;
    cobalagi();
}

void useManaPotion() {
    cout << "Gunakan mana potion: ";
    cin >> mana_potion;
    if (stockMana > 0) {
        mana_potion *= 50;
        stockMana -= 1;
    } else {
        cout << "Stock Hp Potion Habis. Silahkan beli Herbs terlebih dahulu" << endl;
    }
    cout << "Mana Potionmu adalah " << mana_potion << endl;
    cobalagi();
}

void useSwords() {
    string sword;
    cout << "Silahkan Pilih Swords: ";
    cin >> sword;
    swords.push_back(sword);
    cout << "Kamu menggunakan swords " << sword << endl;
    cobalagi();
}

void useStatus() {
    cout << "Herbs " << herbs << endl;
    cout << "HP " << hp_potion << endl;
    cout << "Mana " << mana_potion << endl;
    cout << "Swords: ";
    for (size_t i = 0; i < swords.size(); ++i) {
        cout << swords[i] << " ";
    }
    cout << endl;
    cobalagi();
}

void Menu() {
    cout << "1. Herbs 2. HP Potion 3. Mana Potion 4. Swords 5. Status" << endl;
    int pilihan;
    cout << "Silahkan Pilih Menu: ";
    cin >> pilihan;
    if (pilihan == 1) {
        useHerbs();
    } else if (pilihan == 2) {
        useHPPotion();
    } else if (pilihan == 3) {
        useManaPotion();
    } else if (pilihan == 4) {
        useSwords();
    } else if (pilihan == 5) {
        useStatus();
    } else {
        cout << "Salah Pilih Fungsi" << endl;
    }
}

void cobalagi() {
    char inp;
    cout << "Kembali ke menu? (y/t): ";
    cin >> inp;
    if (inp == 'y' || inp == 'Y') {
        Menu();
    } else {
        cout << "Keluar dari aplikasi" << endl;
    }
}

int main() {
    Menu();
    return 0;
}

