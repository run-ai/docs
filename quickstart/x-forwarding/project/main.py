import cv2

if __name__ == '__main__':
    print('Reading image')
    img = cv2.imread('runai.jpg', 0)

    print('Displaying image')
    cv2.imshow('image', img)
    cv2.waitKey(0)

    print('Destroying windows')
    cv2.destroyAllWindows()

    print('Bye bye')
