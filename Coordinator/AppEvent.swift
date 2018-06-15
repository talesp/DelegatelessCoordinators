//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import Foundation

protocol AppEventType { }

protocol AppEventSubType { }

protocol AppEvent {

    var type: AppEventType { get }
    var subtype: AppEventSubType? { get }

}
