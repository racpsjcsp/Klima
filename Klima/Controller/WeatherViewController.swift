//
//  ViewController.swift
//  Klima
//
//  Created by Rafael Plinio on 03/09/20.
//  Copyright © 2020 Rafael Plinio. All rights reserved.
//

import UIKit
import SwiftSoup

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var dia0: UILabel!
    @IBOutlet weak var min0: UILabel!
    @IBOutlet weak var max0: UILabel!
    
    @IBOutlet weak var dia1: UILabel!
    @IBOutlet weak var min1: UILabel!
    @IBOutlet weak var max1: UILabel!
    
    @IBOutlet weak var dia2: UILabel!
    @IBOutlet weak var min2: UILabel!
    @IBOutlet weak var max2: UILabel!
    
    @IBOutlet weak var dia3: UILabel!
    @IBOutlet weak var min3: UILabel!
    @IBOutlet weak var max3: UILabel!
    
    @IBOutlet weak var dia4: UILabel!
    @IBOutlet weak var min4: UILabel!
    @IBOutlet weak var max4: UILabel!
    
    @IBOutlet weak var dia5: UILabel!
    @IBOutlet weak var min5: UILabel!
    @IBOutlet weak var max5: UILabel!
    
    @IBOutlet weak var dia6: UILabel!
    @IBOutlet weak var min6: UILabel!
    @IBOutlet weak var max6: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //alertar a classe de que o usuário está digitando texto
        searchTextField.delegate = self
        
        
        
        do {
                    let html = """
<div id="week" class="center">

                    <div class="summary">
                              No precipitation throughout the&nbsp;week.
                            </div>

                    <a class="day" data-day="0">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/partly-cloudy-day.png" class="partly-cloudy-day-icon" alt="partly-cloudy-day Icon">
                            </span>

                            <span class="name">
                                            
                                              Today
                                              
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:-2%">14˚</span>

                            <span class="bar" style="width:89%; margin-left:-2%"></span>

                            <span class="maxTemp" style="left:87%">30˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Mostly cloudy throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">14˚</span>
                                        <span class="time">4:49</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">30˚</span>
                                        <span class="time">15:14</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:11</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:56</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.07</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-5/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="1">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/cloudy.png" class="cloudy-icon" alt="cloudy Icon">
                            </span>

                            <span class="name">
                                            
                                                Sun
                                                
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:10%">16˚</span>

                            <span class="bar" style="width:78%; margin-left:10%"></span>

                            <span class="maxTemp" style="left:88%">30˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Overcast throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">16˚</span>
                                        <span class="time">5:53</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">30˚</span>
                                        <span class="time">14:40</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:10</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:56</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.05</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-6/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="2">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/clear-day.png" class="clear-day-icon" alt="clear-day Icon">
                            </span>

                            <span class="name">
                                            
                                                Mon
                                                
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:10%">16˚</span>

                            <span class="bar" style="width:78%; margin-left:10%"></span>

                            <span class="maxTemp" style="left:88%">30˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Clear throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">16˚</span>
                                        <span class="time">5:48</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">30˚</span>
                                        <span class="time">14:50</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:09</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:56</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.04</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-7/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="3">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/clear-day.png" class="clear-day-icon" alt="clear-day Icon">
                            </span>

                            <span class="name">
                                            
                                                Tue
                                                
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:10%">16˚</span>

                            <span class="bar" style="width:78%; margin-left:10%"></span>

                            <span class="maxTemp" style="left:88%">30˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Clear throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">16˚</span>
                                        <span class="time">6:01</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">30˚</span>
                                        <span class="time">14:43</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:08</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:57</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.06</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-8/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="4">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/clear-day.png" class="clear-day-icon" alt="clear-day Icon">
                            </span>

                            <span class="name">
                                            
                                                Wed
                                                
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:15%">17˚</span>

                            <span class="bar" style="width:73%; margin-left:15%"></span>

                            <span class="maxTemp" style="left:88%">30˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Clear throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">17˚</span>
                                        <span class="time">5:52</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">30˚</span>
                                        <span class="time">14:46</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:07</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:57</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.1</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-9/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="5">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/partly-cloudy-day.png" class="partly-cloudy-day-icon" alt="partly-cloudy-day Icon">
                            </span>

                            <span class="name">
                                            
                                                Thu
                                                
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:21%">18˚</span>

                            <span class="bar" style="width:73%; margin-left:21%"></span>

                            <span class="maxTemp" style="left:94%">31˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Mostly cloudy throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">18˚</span>
                                        <span class="time">5:40</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">31˚</span>
                                        <span class="time">14:51</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:06</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:57</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.07</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-10/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="6">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/clear-day.png" class="clear-day-icon" alt="clear-day Icon">
                            </span>

                            <span class="name">
                                            
                                                Fri
                                                
                                          </span>

                        </span>

                        <span class="tempRange">
                            <span class="minTemp" style="left:21%">18˚</span>

                            <span class="bar" style="width:78%; margin-left:21%"></span>

                            <span class="maxTemp" style="left:99%">32˚</span>
                        </span>

                        <span class="toggle">
                            <span class="open">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image x="8" y="4" width="2" height="10" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAAKAQMAAACkKx0KAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABlBMVEX///8AAABVwtN+AAAAAWJLR0QB/wIt3gAAAAlwSFlzAAAuIwAALiMBeKU/dgAAAAtJREFUCNdjYMAEAAAUAAHlhrBKAAAAAElFTkSuQmCC"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>
                            </span>
                            <span class="close">
                                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
                                    <defs>
                                        <style>
                                        .cls-1 {
                                            fill: #778;
                                        }
                                        </style>
                                    </defs>
                                    <circle class="cls-1" cx="9" cy="9" r="9"/>
                                    <image data-name="Layer 1 copy" x="4" y="8" width="10" height="2" xlink:href="data:img/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAACAgMAAAAcD6VDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACVBMVEX///////8AAACO9MPsAAAAAXRSTlP9g+pWxwAAAAFiS0dEAmYLfGQAAAAJcEhZcwAALiMAAC4jAXilP3YAAAAQSURBVAjXYwgNDWAQDQ0AAAciAbVeQnWtAAAAAElFTkSuQmCC"/>
                                </svg>

                            </span>
                        </span>
                    </a>

                    <div class="dayDetails">

                        <div class="summary_container">
                            <div class="summary">Clear throughout the day.</div>

                            <div class="dayExtras">
                                <div class="highLowTemp swip">
                                    <span class="highTemp swip">
                                        <span class="temp">18˚</span>
                                        <span class="time">5:46</span>
                                    </span>

                                    <span class="arrow">→</span>

                                    <span class="lowTemp swap">
                                        <span class="temp">32˚</span>
                                        <span class="time">14:36</span>
                                    </span>
                                </div>

                                <div class="sunTimes">

                                    <span class="sunrise swip">
                                        <img src="/images/sunrise.png" width="28" height="30" alt="Sunrise Icon">
                                        <span class="time">6:05</span>
                                    </span>

                                    <span class="sunset swap">
                                        <img src="/images/sunset.png" width="28" height="30" alt="Sunset Icon">
                                        <span class="time">17:58</span>
                                    </span>

                                </div>

                                <div class="precipAccum swap">
                                    <span class="label swip">Rain</span>
                                    <span class="val swap">

                                        <span class="num swip">0.13</span>
                                        <span class="unit swap">mm</span>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="timeline-container-scroll">
                            <div class="timeline_container">
                                <div class="timeline">
                                    <div class="stripes"></div>
                                    <div class="hour_ticks"></div>
                                    <div class="hours"></div>
                                    <div class="temps"></div>
                                </div>
                            </div>
                        </div>

                        <a class="moreDetails" href="/details/-23.2366,-45.8592/2020-9-11/ca24/en" rel="nofollow">More Details</a>
                    </div>

                    <a class="day" data-day="7">
                        <span class="date__icon__details">
                            <span class="skycon">
                                <img src="/images/weather-icons/cloudy.png" class="cloudy-icon" alt="cloudy Icon">
                            </span>

                            <span class="name">
                                            
                                                Sat
                                                
                                          </span>
                            </span>
"""
                    
                    let element: Element = try SwiftSoup.parse(html).getElementById("week")!
                    
                    let days: Elements = try element.getElementsByClass("day")
                    
                    for divs: Element in days {
                        if let day: Element = try divs.getElementsByClass("name").first() {
                            dia0.text = try day.text()
                            print(try day.text())
                        }
                        if let minTemp: Element = try divs.getElementsByClass("minTemp").first() {
                            min0.text = try minTemp.text()
                            print(try minTemp.text())
                        }
                        if let maxTemp: Element = try divs.getElementsByClass("maxTemp").first() {
                            max0.text = try maxTemp.text()
                            print(try maxTemp.text())
                        }
                    }

                } catch Exception.Error(type: let type, Message: let message) {
                    print(type)
                    print(message)
                } catch {
                    print("")
                }
        }

    
    @IBAction func searchPressed(_ sender: UIButton) {
        //esconde o teclado qdo usuário termina de digitar
        searchTextField.endEditing(true)
    
        print(searchTextField.text!)
    }
    
    //detectar qdo clicar no "ir" (return) do teclado"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Digite algo"
            return false
        }
    }
    
    //limpa o campo de busca
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
        searchTextField.text = ""
    }
    
}

