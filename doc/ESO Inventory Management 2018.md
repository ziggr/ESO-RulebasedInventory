# ESO Inventory Management 2018/2019

## Bank: Mats

Reprogrammed BMR/Zhaksyr to move all mats to bank

Need to reprogram account-wide BMR to move mats to bank (Zancalmo)

## 1 Zhaksyr: CP150 mats, Recipes and Sell Stuff

- CP150 crafting materials
	- BS CL WW CL JW raw and refined,
	- tempers
- Recipes
- Intricate Jewelry
- ornate (sell)

### Pull from bank  rules

- [x] CP150 mats
	`((material) AND (itemname("rubedite","ancestor","rubedo","ruby ash","platinum")))
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
- [x] supple root, foul hide, carapace, daedra husk, elemental essence, ectoplasm
	`((junk) AND itemname("foul hide","supple root","carapace","elemental essence","daedra husk","ectoplasm"))`

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

### Pull from bank

- [x] fingerless gloves
	`(costume) OR (disguise) OR ((armor) AND (armor_none))`

## 6 Hagnar: Provisioning

### Pull from bank

- [x] ingredients
  `(ingredient)`
- [x] recipe fragments
  `(recipe_fragment)`

## 7 Daenir: Alchemy

### Pull from bank

- [x] Provisioning
	`(material_alchemy)`

## 8 Zugbesha: trait and sub-CP150 mats

Sell when we get to a stack of 200

### Pull from bank

- [x] sub-CP150 materials
  ```
     ((material_blacksmithing) AND (NOT(itemname("rubedite"))))
  OR ((material_clothier)      AND (NOT(itemname("ancestor","rubedo"))))
  OR ((material_woodworking)   AND (NOT(itemname("ruby"))))
  OR ((material_jewelry)       AND (NOT(itemname("platinum"))))
  ```

- [x] trait
	`(material_trait)`



## 9 Zacalmo: motif stones, pages

### Pull from bank

- [x] motif stones
	`(material_style)`
- [x] motif pages
	`(itemtype_racial_style_motif)`


# Housing Bank

- **Consumable Fireworks** Spiral Hat Dazzler, Cherry Blossom, Mud Ball, etc
