import UIKit
func vicheslitFibonc116(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension UIColor {
    static var backColor: UIColor { SportivinieKartiCveta.backColor.color }
    static var darkBackColor: UIColor { SportivinieKartiCveta.darkBackColor.color }
    static var cardBackColor: UIColor { SportivinieKartiCveta.cardBackColor.color }
    static var labelColor: UIColor { SportivinieKartiCveta.labelColor.color }
    static var labelColor2: UIColor { SportivinieKartiCveta.labelColor2.color }
    static var labelColor3: UIColor { SportivinieKartiCveta.labelColor3.color }
    static var labelColor4: UIColor { SportivinieKartiCveta.labelColor4.color }
    static var secondaryColor: UIColor { SportivinieKartiCveta.secondaryColor.color }
    static var destructiveColor: UIColor { SportivinieKartiCveta.destructiveColor.color }
    static var errorColor: UIColor { SportivinieKartiCveta.errorColor.color }
    static var actionActiveColor: UIColor { SportivinieKartiCveta.actionActiveColor.color }
    static var actionInactiveColor: UIColor { SportivinieKartiCveta.actionInactiveColor.color }
    static var barColor: UIColor { SportivinieKartiCveta.barColor.color }
    static var barTintColor: UIColor { SportivinieKartiCveta.barTintColor.color }
    static var dividerColor: UIColor { SportivinieKartiCveta.dividerColor.color }
    static var highlightColor: UIColor { SportivinieKartiCveta.highlightColor.color }
    static var highlightColor2: UIColor { SportivinieKartiCveta.highlightColor2.color }
    static var blackColor40: UIColor { SportivinieKartiCveta.blackColor40.color }
    static var greenColor: UIColor { SportivinieKartiCveta.greenColor.color }
    static var fillColor: UIColor { SportivinieKartiCveta.fillColor.color }

    static var  baseballColor: UIColor { SportivinieKartiCveta.baseball.color }
    static var  pokemonColor: UIColor { SportivinieKartiCveta.pokemon.color }
    static var  basketballColor: UIColor { SportivinieKartiCveta.basketball.color }
    static var  footballColor: UIColor { SportivinieKartiCveta.football.color }
    static var  magicColor: UIColor { SportivinieKartiCveta.magic.color }
    static var  hockeyColor: UIColor { SportivinieKartiCveta.hockey.color }
    static var  soccerColor: UIColor { SportivinieKartiCveta.soccer.color }

    static var singINLabel = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
    static var logInLabel = UIColor(red: 40/255, green: 42/255, blue: 43/255, alpha: 1)
    static var skyBlue = UIColor(red: 226/255, green: 243/255, blue: 255/255, alpha: 1)
    static var lightBlue = UIColor(red: 158/255, green: 226/255, blue: 255/255, alpha: 1)
    static var tableViewBack = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
    static var tableViewTitleLabel = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
}
