# ESO Inventory Management 2018/2019

## Bank: Mats

Reprogrammed BMR/Zhaksyr to move all mats to bank

Need to reprogram account-wide BMR to move mats to bank (Zancalmo)

## 1 Zhaksyr: CP150 mats, Recipes and Sell Stuff

- CP150 crafting materials
	- BS CL WW CL raw and refined,
	- tempers
- Recipes
- Intricate Jewelry
- ornate (sell)

### Pull from bank  rules

- [x] CP150 mats
	`((material) AND (itemname("rubedite","ancestor","rubedo","ruby ash")))
- [x] Tempers
	`(material_booster)`
- [x] Kuta
	`((aspect) and (legendary))`
- [ ] Intricate Jewelry UNTESTED
	`((item_jewelry) AND (intricate))`
- [ ] ornate UNTESTED
	`(ornate)`

### Push to Bank rules, GENERIC

```
(material)
OR (intricate)
OR (ornate)
OR (recipe)
OR (survey)
OR ((soulgem) AND (normal))
```


## 2 Zecorwyn: Master Writs

Craft _or sell_ writs when this gets to 100+ master writs.

- Master Writs (100+) whose WW mat price is 300gold/voucher or more

- **Master Merchant + Net Worth ON** to track master writ inventory value

### Pull from bank 

- [ ] Master Writs UNTESTED   (TODO: ww mat 300gpv+)
	`(masterwrit)`

## 3 Lilwen: Enchanting

### Pull from bank
Exclude Bag-to-bank

- [x] Enchanting mats
	`((aspect) AND (NOT (legendary))) OR (essence) OR (potency)`

### Push to bank

- [ ] Kuta UNTESTED
	`((aspect) AND (legendary))`
	
## 4 Alexander Mundus: Crow and Countess

### Pull from bank

- [x] Laundered stuff
	`(treasure)`
	"trophy" is not the right option here, does not pick up laundered stuff, DOES pick up surveys, Psijic fragments.

### Misc Trash

100x of each, sell extras. Even the hard-to-get Elemental Essence isn't _that_ hard to acquire.

- Carapace
- Daedra Husk
- Ectoplasm
- Elemental Essence
- Foul Hide
- Supple Root

### Misc Trophies

- Stolen laundered stuff. Keep as much as you can while still being able to breathe during Day 1 crafting writ bursts.

### Ornate Armor

10x pieces is enough. You can acquire more so quickly with a round of daily writs.

## 5 Simone: Costume Clothing

- Fingerless Gloves
- Travelers Boots
- Shadowsilk Gem


## 6 Hagnar: Provisioning

## 7 Daenir

## 8 Zugbesha

## 9 Zacalmo
