//
//  HomeScrolling.swift
//  iosApp
//
//  Created by Marty Ulrich on 1/10/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import SwiftUI

protocol HomeScrollingCellModel: View where DataType: Identifiable {
	associatedtype DataType
	
	init(data: DataType)
}

struct HomeScrollingContentView<Model: HomeScrollingCellModel>: View {
	@Binding var selectedDataModel: Model.DataType?
	let dataModels: [Model.DataType]
	let title: String
	let spacing: CGFloat
	
	var body: some View {
		VStack {
			SectionHeader(title: title)
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(alignment: .firstTextBaseline, spacing: nil) {
					ForEach(dataModels) { data in
						Model(data: data)
							.onTapGesture { selectedDataModel = data }
							.padding(.trailing, spacing)
					}
				}
			}
		}
	}
}

struct HomeScrollingContentView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			HomeScrollingContentView<ArtistCell>(selectedDataModel: .constant(nil), dataModels: DummyData.artists, title: "NEWM Artists", spacing: 8)
			HomeScrollingContentView<SongCell>(selectedDataModel: .constant(nil), dataModels: DummyData.songs, title: "NEWM Songs", spacing: 8)
			HomeScrollingContentView<PlaylistCell>(selectedDataModel: .constant(nil), dataModels: DummyData.playlists, title: "Curated Playlists", spacing: 12)
		}
	}
}
