//
//  EventsNewView.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI

struct EventsNewView: View {
    
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField: Bool
    
//    @State private var distance: Double = 5
//
//    @State private var isEditing: Bool = false
//    @State private var isSelected: Bool = false
    
    @State private var eventDescription: String = ""
//    @State private var wordCount: Int = 0
    @State private var charCount: Int = 0
//    @State private var color: Color = Color.indigo
    @State private var characterLimit = 120
//    @FocusState private var nameIsFocused: Bool
    
    @State private var isSelectedMusic: Bool = false
    @State private var isSelectedFestival: Bool = false
    @State private var isSelectedSocial: Bool = false
    @State private var isSelectedUnrest: Bool = false
    @State private var isSelectedAccident: Bool = false
    @State private var isSelectedDisaster: Bool = false
    @State private var isSelectedNature: Bool = false
    @State private var isSelectedFood: Bool = false
    @State private var isSelectedPolitical: Bool = false
    @State private var isSelectedExercise: Bool = false
    @State private var isSelectedSale: Bool = false
    @State private var isSelectedOther: Bool = false
//    @State private var isSelectedActive: Bool = false
//    @State private var isSelectedDone: Bool = false
    
    var body: some View {

        VStack {
            Text("Report Events")
                .fontWeight(.thin)
                .padding()
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
                .foregroundColor(.white)

            
            Text("Report an ongoing Event around you.")
                .padding()
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)


            Text("Pictures")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(vm.myImages) { MyImage in
                            VStack {
                                Image(uiImage: MyImage.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                                Text(MyImage.name)
                            }
                            .onTapGesture {
                                vm.display(MyImage)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                if let image = vm.image {
                    ZoomableScrollView {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity )
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity )
                        .padding(.horizontal)
                }
                VStack {
                    HStack {
                        TextField("Image Name", text: $vm.imageName) { isEditing in
                            vm.isEditing = isEditing
                        }
                        .focused($nameField, equals: true)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 310, alignment: .leading)
                    
                        Button {
                            
                            if vm.selectedImage == nil {
                                vm.addMyImage(vm.imageName, image: vm.image!)
                            } else {
                                vm.updateSelected()
                                nameField = false
                            }
                            
                        } label: {
                            Image(systemName: vm.selectedImage == nil ? "square.and.arrow.down" : "square.and.arrow.up")
                        }
                        .buttonStyle(modifiedButtonStyle())
                        .disabled(vm.buttonDisabled)
                        .opacity(vm.buttonDisabled ? 0.5 : 1)
                        
                        if !vm.deleteButtonIsHidden {
                            Button {
                                vm.deleteSelected()
                            } label: {
                                Image(systemName: vm.selectedImage == nil ? "square.and.arrow.up" : "trash")
                            }
                            .buttonStyle(modifiedButtonStyle())
                            .disabled(vm.buttonDisabled)
                            .opacity(vm.buttonDisabled ? 0.5 : 1)
                        }
                    }
                    
                    HStack {
                        Button {
                            vm.source = .camera
                            vm.showPhotoPicker()
                        } label: {
                            Image(systemName: "camera")
    //                        Text("Camera")
                        }
                        .buttonStyle(modifiedButtonStyle())
                        .alert("Error", isPresented: $vm.showCameraAlert, presenting: vm.cameraError, actions:
                                { cameraError in
                            cameraError.button
                        }, message: { cameraError in
                            Text(cameraError.message)
                        })
                        
                        Button {
                            vm.source = .library
                            vm.showPhotoPicker()
                        } label: {
                            Image(systemName: "photo.on.rectangle.angled")
    //                        Text("Photos")
                        }.buttonStyle(modifiedButtonStyle())
                            
                    }
                }
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    vm.loadMyImagesJSONFile()
                }
            }
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
            }
            .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError, actions:
                    { cameraError in
                cameraError.button
            }, message: { cameraError in
                Text(cameraError.message)
            })
            
            

            
//            Text("Description")
//                .fontWeight(.thin)
//                .padding()
//                .font(.title)
//                .frame(maxWidth: .infinity, alignment: .leading)
//
            
//
//            ZStack {
//                TextEditor(text: $eventDescription)
//                    .frame(width: 400, height: 80, alignment: .leading)
//                    .border(Color.gray, width: 0.5)
//                    .font(.body)
//                    .lineLimit(2)
//                    .cornerRadius(5)
//                    .onReceive(eventDescription.publisher.collect()) {
//                        let s = String($0.prefix(characterLimit))
//                        if eventDescription != s {
//                            eventDescription = s
//                        }
//                    }
//                    .onChange(of: eventDescription) { eventDescription in
//                        let letters = eventDescription.trimmingCharacters(in: .whitespaces).count
//                        self.charCount = letters
//                    }
//
//                Text("(\(charCount) / 120 chars)")
//                        .foregroundColor(.secondary)
//                        .padding([.bottom, .trailing], 5)
//                        .frame(width: 400, height: 80, alignment: .bottomTrailing)
//            }

            
            
            
            Text("Categories")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)

            
            Group {
                HStack {
                    Toggle(isOn: $isSelectedMusic) { Label(isSelectedMusic ? "Music" : "Music", systemImage: "music.quarternote.3").symbolVariant(isSelectedMusic ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedFestival) { Label(isSelectedFestival ? "Festival" : "Festival", systemImage: "music.mic").symbolVariant(isSelectedFestival ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedSocial) { Label(isSelectedSocial ? "Social" : "Social", systemImage: "person.3").symbolVariant(isSelectedSocial ? .fill : .none) }
                }
                HStack {
                    Toggle(isOn: $isSelectedUnrest) { Label(isSelectedUnrest ? "Unrest" : "Unrest", systemImage: "figure.wave").symbolVariant(isSelectedUnrest ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedAccident) { Label(isSelectedAccident ? "Accident" : "Accident", systemImage: "airplane.arrival").symbolVariant(isSelectedAccident ? .fill : .none) }

                    Toggle(isOn: $isSelectedDisaster) { Label(isSelectedDisaster ? "Disaster" : "Disaster", systemImage: "waveform").symbolVariant(isSelectedDisaster ? .fill : .none) }
                }
                HStack {
                    Toggle(isOn: $isSelectedNature) { Label(isSelectedNature ? "Nature" : "Nature", systemImage: "globe.americas").symbolVariant(isSelectedNature ? .fill : .none) }
                
                    Toggle(isOn: $isSelectedFood) { Label(isSelectedFood ? "Food" : "Food", systemImage: "cart").symbolVariant(isSelectedFood ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedPolitical) { Label(isSelectedPolitical ? "Political" : "Political", systemImage: "building.columns").symbolVariant(isSelectedPolitical ? .fill : .none) }
                }
                HStack {
                    Toggle(isOn: $isSelectedSale) { Label(isSelectedSale ? "Sale" : "Sale", systemImage: "dollarsign.circle").symbolVariant(isSelectedSale ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedExercise) { Label(isSelectedExercise ? "Exercise" : "Exercise", systemImage: "bolt").symbolVariant(isSelectedExercise ? .fill : .none) }
                    
                    Toggle(isOn: $isSelectedOther) { Label(isSelectedOther ? "Other" : "Other", systemImage: "infinity").symbolVariant(isSelectedOther ? .fill : .none) }
                }
            }.toggleStyle(.button)
            .tint(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
            
            
            Spacer()

        }

    }
}

struct EventsNewView_Previews: PreviewProvider {
    static var previews: some View {
        EventsNewView()
            .environmentObject(ViewModel())
    }
}







// This section helps with the automatic dismissal of the keyboard when screen is tapped.
extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tapGesture.name = "MyTapGesture"
        window.addGestureRecognizer(tapGesture)
    }
 }

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false // set to `false` if you don't want to detect tap during other gestures
    }
}
