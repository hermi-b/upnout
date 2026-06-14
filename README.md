//
//  Quest_view.swift
//  upnout
//
//  Created by Hermela Benyam on 4/10/25.
//

import SwiftUI

struct Quest_view: View {
    var body: some View {
        ZStack {
            // Set the background color using the RGB values
            Color(red: 118/255, green: 157/255, blue: 116/255)
                .ignoresSafeArea()

            VStack {
                NavigationStack {
                    NavigationLink(destination: soloquestView()) {
                        CloudText(text: "Solo", width: 250, height: 100)
                            .padding(.bottom, 50)
                    } // NavigationLink
                    
                    CloudText(text: "w/ Friends", width: 250, height: 100)
                } // end of NavigationStack
            } // end of VStack
        } // end of ZStack
    } // end of body
}

#Preview {
    Quest_view()
}


#Preview {
    Quest_view()
}
